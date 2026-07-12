//
//  ChatImageStore.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 13.07.2026.
//

import Foundation

enum ChatImageStore {
    private static let folderName = "ChatImages"

    private static var rootDirectory: URL {
        let base = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
            ?? FileManager.default.temporaryDirectory
        return base.appendingPathComponent(folderName, isDirectory: true)
    }

    static func sessionDirectory(sessionID: UUID) -> URL {
        rootDirectory.appendingPathComponent(sessionID.uuidString.lowercased(), isDirectory: true)
    }

    static func fileURL(sessionID: UUID, fileName: String) -> URL {
        sessionDirectory(sessionID: sessionID).appendingPathComponent(fileName, isDirectory: false)
    }

    @discardableResult
    static func ensureSessionDirectory(sessionID: UUID) throws -> URL {
        let directory = sessionDirectory(sessionID: sessionID)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        return directory
    }

    static func saveJPEG(sessionID: UUID, data: Data) throws -> String {
        try ensureSessionDirectory(sessionID: sessionID)
        let fileName = "\(UUID().uuidString.lowercased()).jpg"
        try data.write(to: fileURL(sessionID: sessionID, fileName: fileName), options: .atomic)
        return fileName
    }

    static func loadData(sessionID: UUID, fileName: String) -> Data? {
        try? Data(contentsOf: fileURL(sessionID: sessionID, fileName: fileName))
    }

    static func delete(sessionID: UUID, fileNames: [String]) {
        for fileName in fileNames {
            try? FileManager.default.removeItem(at: fileURL(sessionID: sessionID, fileName: fileName))
        }
    }
}
