//
//  Cat+Utils.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 18/01/2025.
//
import Foundation

extension Cat {
    static var random: Cat {
        var selectedTags: Set<String> = Set()
        let tagsCount = Int.random(in: 0...5)
        while selectedTags.count < tagsCount {
            selectedTags.insert(RandomGenerator.getTag())
        }

        return Cat(
            id: UUID().uuidString,
            name: RandomGenerator.getName() ?? Configuration.defaultCatName,
            tags: [String](selectedTags).sorted(), owner: RandomGenerator.getName()
        )
    }
}

extension Cat {
    var hasOwner: Bool {
        guard let owner = owner, !owner.isEmpty else {
            return false
        }
        return owner.lowercased() != "null"
    }

    func getCatOwnerLegend() -> String {
        guard hasOwner, let owner = owner else {
            return "I am a free cat!"
        }

        if owner.lowercased() != "null" {
            return "My owner is \(owner)"
        } else {
            return "I am a free cat!"
        }
    }
}

extension Cat {
    var hasName: Bool {
        return (!name.isEmpty) && (name != Configuration.defaultCatName)
    }

    func getNameLegend() -> String {
        if hasName {
            return "My name is \(name)"
        } else {
            return "No one knows my name"
        }
    }
}
