//
//  SearchScreen.swift
//  kcdsearch
//
//  Created by ParasKCD on 14/3/26.
//

import SwiftUI

struct SearchScreen: View {
    @Environment(SearchViewModel.self) private var viewModel

    let query: String

    var body: some View {
        List {
            if viewModel.results.isEmpty && !viewModel.isLoading {
                ContentUnavailableView(
                    "No Results",
                    systemImage: "magnifyingglass",
                    description: Text("No results found for \"\(query)\"")
                )
            }

            ForEach(viewModel.results) { result in
                WebResultCard(
                    params: WebResultCardParams(result: result)
                )
                .listRowSeparator(.hidden)
                .onAppear {
                    if result.id == viewModel.results.last?.id && viewModel.hasMorePages {
                        Task {
                            await viewModel.loadNextPage(query: query)
                        }
                    }
                }
            }

            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle(query)
        #if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .task {
            await viewModel.search(query: query)
        }
        .overlay {
            if let error = viewModel.error {
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            }
        }
    }
}
