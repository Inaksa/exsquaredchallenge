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

    var body: some View {
        List {
            ForEach(viewModel.cats, id: \.id) { cat in
                CatCell(cat: cat)
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
    }
}

#Preview {
    MainView()
}

