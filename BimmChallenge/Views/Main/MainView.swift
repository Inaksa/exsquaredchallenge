//
//  MainView.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//
import UIKit
import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State private var filterText: String = ""
    @State private var showCatDetail: Bool = false

    private var filteredCats: [Cat] {
        if filterText == "" {
            return viewModel.cats
        } else {
            var cats: [Cat] = []
            viewModel.cats.forEach { cat in
                if cat.tags.first(where: { $0.localizedCaseInsensitiveContains(filterText) }) != nil {
                    cats.append(cat)
                }
            }
            return cats
        }
    }

    var body: some View {
        List {
            ForEach(filteredCats, id: \.id) { cat in
                NavigationLink {
                    CatDetail(cat: cat)
                } label: {
                    CatCell(cat: cat)
                }
                    .listRowSeparator(.hidden)
            }

            if viewModel.reachEndOfList {
                EmptyView()
            } else {
                VStack {
                    Text("Load More...")
                        .frame(maxWidth: .infinity)
                        .padding()

                }
                .onAppear {
                    viewModel.loadNextPage()
                }
                .background(Color.cyan)
            }

        }
        .listStyle(.plain)
        .navigationTitle("Cats")
        .refreshable {
            viewModel.loadFirstPage()
        }
        .searchable(text: $filterText)
    }
}

#Preview {
    MainView()
}

