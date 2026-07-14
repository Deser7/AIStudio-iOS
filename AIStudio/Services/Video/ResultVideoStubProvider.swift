//
//  ResultVideoStubProvider.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 06.07.2026.
//

import AVFoundation

enum ResultVideoStubError: Error {
    case writerSetupFailed
    case pixelBufferCreationFailed
    case writingFailed
}

enum ResultVideoStubProvider {
    private static let cacheFileName = "AIStudio-ResultStub.mp4"

    static func videoURL() throws -> URL {
        if let bundled = Bundle.main.url(forResource: "ResultStub", withExtension: "mp4") {
            return bundled
        }

        let cacheURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(cacheFileName)

        if FileManager.default.fileExists(atPath: cacheURL.path) {
            return cacheURL
        }

        try generateVideo(at: cacheURL)
        return cacheURL
    }

    private static func generateVideo(at url: URL) throws {
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }

        let writer = try AVAssetWriter(outputURL: url, fileType: .mp4)

        let outputSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: 360,
            AVVideoHeightKey: 640
        ]

        let input = AVAssetWriterInput(mediaType: .video, outputSettings: outputSettings)
        input.expectsMediaDataInRealTime = false

        let adaptor = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: input,
            sourcePixelBufferAttributes: [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
                kCVPixelBufferWidthKey as String: 360,
                kCVPixelBufferHeightKey as String: 640
            ]
        )

        guard writer.canAdd(input) else {
            throw ResultVideoStubError.writerSetupFailed
        }

        writer.add(input)
        writer.startWriting()
        writer.startSession(atSourceTime: .zero)

        guard let pixelBuffer = makePixelBuffer() else {
            throw ResultVideoStubError.pixelBufferCreationFailed
        }

        while !input.isReadyForMoreMediaData {
            Thread.sleep(forTimeInterval: 0.01)
        }

        guard adaptor.append(pixelBuffer, withPresentationTime: .zero) else {
            throw ResultVideoStubError.writingFailed
        }

        input.markAsFinished()

        let group = DispatchGroup()
        group.enter()
        writer.finishWriting {
            group.leave()
        }
        group.wait()

        guard writer.status == .completed else {
            throw writer.error ?? ResultVideoStubError.writingFailed
        }
    }

    private static func makePixelBuffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            360,
            640,
            kCVPixelFormatType_32ARGB,
            nil,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, []) }

        if let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) {
            memset(baseAddress, 0, CVPixelBufferGetDataSize(pixelBuffer))
        }

        return pixelBuffer
    }
}
