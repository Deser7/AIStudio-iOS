//
//  ChatViewModel+Speech.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 31.07.2026.
//

import Foundation

extension ChatViewModel {
    func microTapped() {
        guard !isGenerating, !isRecording else { return }
        guard pendingAttachments.isEmpty, !isAttachmentLoading else { return }

        if speechCapture.authorizationStatus.isGranted {
            startRecording()
            return
        }

        mediaAccessAlert = .microphone
    }

    func cancelRecording() {
        speechCapture.cancel()
        resetRecordingState()
    }

    func confirmRecording() {
        guard isRecording else { return }
        speechCapture.stop()
        appendTranscript(draftTranscript)
        resetRecordingState()
    }

    func resolveMicrophoneAccess() async {
        let currentStatus = speechCapture.authorizationStatus

        switch currentStatus {
        case .notDetermined:
            let status = await speechCapture.requestAccess()
            mediaAccessAlert = nil
            guard status.isGranted else { return }
            startRecording()

        case .denied, .restricted:
            mediaAccessAlert = nil
            openSettingsEvent = UUID()

        case .authorized:
            mediaAccessAlert = nil
            startRecording()
        }
    }

    private func startRecording() {
        draftTranscript = ""
        recordingLevel = 0
        isRecording = true

        do {
            try speechCapture.start(
                localeIdentifier: Self.speechLocaleIdentifier,
                onAudioLevel: { [weak self] level in
                    self?.recordingLevel = level
                },
                onTranscript: { [weak self] text in
                    self?.draftTranscript = text
                }
            )
        } catch {
            resetRecordingState()
        }
    }

    private func appendTranscript(_ raw: String) {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if promptText.isEmpty {
            promptText = trimmed
        } else if promptText.last?.isNewline == true || promptText.last?.isWhitespace == true {
            promptText += trimmed
        } else {
            promptText += " " + trimmed
        }
    }

    private func resetRecordingState() {
        isRecording = false
        recordingLevel = 0
        draftTranscript = ""
    }

    /// Maps `LanguageStore.resolvedLocale` to a speech recognizer locale.
    private static var speechLocaleIdentifier: String {
        switch LanguageStore.resolvedLocale.language.languageCode?.identifier {
        case "ru": "ru-RU"
        default: "en-US"
        }
    }
}
