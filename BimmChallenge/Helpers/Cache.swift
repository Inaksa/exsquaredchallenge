//
//  Cache.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import Foundation

class Cache {
    private enum Configuration {
        static let extensionCacheFile: String = "cacheddata"
    }
    static let shared = Cache()
    private init() {}

    private var cachedFiles: [URL] = {
        do {

            // Get the document directory url
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )

            let files = try FileManager.default.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: [.nameKey])
            return files.filter({ $0.lastPathComponent.hasSuffix(Configuration.extensionCacheFile) })
        } catch {
            print(error)
        }
        return []
    }()
    private var keys: [String] {
        cachedFiles.map(\.lastPathComponent)
    }

    func isDefined(key: String) -> Bool {
        keys.contains(where: { $0.hasSuffix(key + "." + Configuration.extensionCacheFile) })
    }

    func saveData(_ data: Data, for key: String) {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let filePath = documentDirectory.appendingPathComponent("\(key).\(Configuration.extensionCacheFile)")
            try data.write(to: filePath)

            print("Saving data to \(filePath)")
        } catch {
            print(error)
        }
    }

    func getData(for key: String) -> Data? {
        guard let fileName = cachedFiles.filter({ $0.lastPathComponent.hasPrefix(key) }).first,
              let stringContent = try? String(contentsOf: fileName, encoding: .utf8),
              let data = stringContent.data(using: .utf8)
        else {
            return nil
        }

        return data
    }

    func resetCache() {
        do {
            try cachedFiles.forEach { try FileManager.default.removeItem(at: $0) }
        } catch {
            print("Error: \(error).")
        }
    }
}
