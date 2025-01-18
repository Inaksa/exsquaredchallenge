//
//  Cat.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import Foundation

typealias CatTag = String

final class Cat: Codable, Identifiable, Hashable, Equatable {
    var id: String
    var tags: [CatTag]
    var owner: String?
    var createdAt: Date?
    var updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
        case owner
        case createdAt
        case updatedAt
    }

    init(id: String, tags: [CatTag] = [], owner: String? = nil, createdAt: Date? = nil, updatedAt: Date? = nil) {
        self.id = id
        self.tags = tags
        self.owner = owner
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let decodedTags = try container.decodeIfPresent([CatTag].self, forKey: .tags)
        self.tags = decodedTags ?? []
        self.owner = try container.decodeIfPresent(String.self, forKey: .owner)

        let df = DateFormatter.caasDateFormatter
        if let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt),
           let createdAtDate = df.date(from: createdAtString) {
            self.createdAt = createdAtDate
        }
        if let updatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt),
           let updatedAtDate = df.date(from: updatedAtString) {
            self.createdAt = updatedAtDate
        }
    }

    static func == (lhs: Cat, rhs: Cat) -> Bool { lhs.id == rhs.id }

    var hashValue: Int { id.hashValue }

    func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}

extension Cat {
    static var random: Cat {
        let tags: [String] = [
            "kitten",
            "several",
            "gif",
            "manspreading",
            "closed eyes",
            "sleepy",
            "bed",
            "gif",
            "tuxedo",
            "vending machine",
            "stuck",
            "glass",
            "trapped",
            "norwegian forest cat",
            "daisy",
            "gaming",
            "pc",
            "small cat",
            "brazilian",
            "brazilian cat",
            "brasileira",
            "female cat",
            "female",
            "black & white",
            "donna",
            "londrinense",
            "londrina",
            "cute cat",
            "cute",
        ]
        var selectedTags: Set<String> = Set()
        let tagsCount = Int.random(in: 0...5)
        while selectedTags.count < tagsCount {
            // There is always one element
            selectedTags.insert(tags.randomElement()!)
        }
        
        return Cat(id: UUID().uuidString, tags: [String](selectedTags).sorted())
    }
}
