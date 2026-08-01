//
//  SpeechCaptureService.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 31.07.2026.
//

import AVFoundation
import Speech

enum SpeechAuthorizationStatus: Sendable {
    case notDetermined
    case denied
    case restricted
    case authorized

    var isGranted: Bool {
        self == .authorized
    }
}

enum SpeechCaptureError: Error {
    case recognizerUnavailable
    case engineStartFailed
}

@MainActor
protocol SpeechCapturing: AnyObject {
    var authorizationStatus: SpeechAuthorizationStatus { get }
    func requestAccess() async -> SpeechAuthorizationStatus
    func start(
        localeIdentifier: String,
        onAudioLevel: @escaping @MainActor (CGFloat) -> Void,
        onTranscript: @escaping @MainActor (String) -> Void
    ) throws
    func stop()
    func cancel()
}

@MainActor
final class SpeechCaptureService: SpeechCapturing {
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?
    private var smoothedLevel: CGFloat = 0

    var authorizationStatus: SpeechAuthorizationStatus {
        Self.combinedStatus(
            speech: SFSpeechRecognizer.authorizationStatus(),
            microphone: AVAudioApplication.shared.recordPermission
        )
    }

    func requestAccess() async -> SpeechAuthorizationStatus {
        let speechStatus = await requestSpeechAuthorization()
        guard speechStatus == .authorized || speechStatus == .notDetermined else {
            return Self.mapSpeech(speechStatus)
        }

        if AVAudioApplication.shared.recordPermission != .granted {
            _ = await AVAudioApplication.requestRecordPermission()
        }

        return authorizationStatus
    }

    func start(
        localeIdentifier: String,
        onAudioLevel: @escaping @MainActor (CGFloat) -> Void,
        onTranscript: @escaping @MainActor (String) -> Void
    ) throws {
        cancel()

        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: localeIdentifier))
        guard let recognizer, recognizer.isAvailable else {
            throw SpeechCaptureError.recognizerUnavailable
        }
        speechRecognizer = recognizer

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        recognitionRequest = request

        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            request.append(buffer)
            let rawLevel = Self.normalizedLevel(from: buffer)
            Task { @MainActor in
                guard let self else { return }
                self.smoothedLevel = self.smoothedLevel * 0.7 + rawLevel * 0.3
                onAudioLevel(self.smoothedLevel)
            }
        }

        recognitionTask = recognizer.recognitionTask(with: request) { result, _ in
            guard let result else { return }
            let text = result.bestTranscription.formattedString
            Task { @MainActor in
                onTranscript(text)
            }
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            cancel()
            throw SpeechCaptureError.engineStartFailed
        }
    }

    func stop() {
        recognitionRequest?.endAudio()
        tearDownEngine(deactivateSession: true)
        recognitionTask?.finish()
        recognitionTask = nil
        recognitionRequest = nil
        speechRecognizer = nil
    }

    func cancel() {
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest = nil
        tearDownEngine(deactivateSession: true)
        speechRecognizer = nil
        smoothedLevel = 0
    }

    private func tearDownEngine(deactivateSession: Bool) {
        if audioEngine.isRunning {
            audioEngine.stop()
        }
        audioEngine.inputNode.removeTap(onBus: 0)

        guard deactivateSession else { return }
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    private func requestSpeechAuthorization() async -> SFSpeechRecognizerAuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
    }

    private static func combinedStatus(
        speech: SFSpeechRecognizerAuthorizationStatus,
        microphone: AVAudioApplication.recordPermission
    ) -> SpeechAuthorizationStatus {
        let speechMapped = mapSpeech(speech)
        let micMapped = mapMicrophone(microphone)

        if speechMapped == .denied || micMapped == .denied {
            return .denied
        }
        if speechMapped == .restricted || micMapped == .restricted {
            return .restricted
        }
        if speechMapped == .notDetermined || micMapped == .notDetermined {
            return .notDetermined
        }
        return .authorized
    }

    private static func mapSpeech(_ status: SFSpeechRecognizerAuthorizationStatus) -> SpeechAuthorizationStatus {
        switch status {
        case .notDetermined: .notDetermined
        case .denied: .denied
        case .restricted: .restricted
        case .authorized: .authorized
        @unknown default: .denied
        }
    }

    private static func mapMicrophone(_ permission: AVAudioApplication.recordPermission) -> SpeechAuthorizationStatus {
        switch permission {
        case .undetermined: .notDetermined
        case .denied: .denied
        case .granted: .authorized
        @unknown default: .denied
        }
    }

    private static func normalizedLevel(from buffer: AVAudioPCMBuffer) -> CGFloat {
        guard let channelData = buffer.floatChannelData?[0] else { return 0 }
        let frameLength = Int(buffer.frameLength)
        guard frameLength > 0 else { return 0 }

        var sum: Float = 0
        for index in 0..<frameLength {
            let sample = channelData[index]
            sum += sample * sample
        }

        let rms = sqrt(sum / Float(frameLength))
        return min(1, CGFloat(rms) * 5)
    }
}
