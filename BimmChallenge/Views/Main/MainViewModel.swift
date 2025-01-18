//
//  MainViewModel.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 17/01/2025.
//
import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = true
    @Published private(set) var reachEndOfList: Bool = false

    private(set) var currentPage: Int = 1

    init() {
        Task {
            let remoteCats = await getCats(page: 1, numberPerPage: Configuration.catsPerPage)
            DispatchQueue.main.async {
                self.cats.append(contentsOf: remoteCats)
            }
        }
    }

    private func getCats(page: Int, numberPerPage: Int) async -> [Cat] {
        let limit = numberPerPage
        let skip = (page - 1) * limit
        currentPage = page
        guard let validURL = Bundle.main.url(
            forResource: Configuration.Datasource.filename,
            withExtension: Configuration.Datasource.fileExtension
        )
        else { return [] }
        isLoading = true
        let result = try? await URLSession.shared.data(from: validURL)
        isLoading = false
        guard let data = result?.0,
              let elems = try? JSONDecoder().decode([Cat].self, from: data)
        else {
            return []
        }

        return [Cat](elems.dropFirst(skip))
    }

    func loadNextPage() {
        let resultsPerPage: Int = 10
        Task {
            let elems = await getCats(page: currentPage + 1, numberPerPage: Configuration.catsPerPage)
            cats.append(contentsOf: elems)
            reachEndOfList = (elems.count < resultsPerPage)
        }
    }

    func loadFirstPage() {
        currentPage = 0
        cats.removeAll()
        loadNextPage()
    }

    func saveCat(_ cat: Cat) {
        cat.updatedAt = Date()
        if let anIndex = cats.firstIndex(where: { $0.id == cat.id }) {
            cats[anIndex] = cat
        } else {
            cat.createdAt = Date()
            cats.append(cat)
        }
    }
}
