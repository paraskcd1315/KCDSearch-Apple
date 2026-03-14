//
//  Search Service.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class SearchService {
    static let shared = SearchService()

    private let searchRepository = SearchRepository()

    private(set) var results: [SearchResult] = []
    private(set) var isLoading = false
    private(set) var error: String? = nil
    private(set) var currentPage = 1
    private(set) var hasMorePages = true
    private(set) var totalResults = 0

    private(set) var suggestions: [String] = []
    private(set) var isSuggestionsLoading = false
    private(set) var suggestionsError: String? = nil

    private var suggestionsTask: Task<Void, Never>?

    private init() {}

    // MARK: - Search

    func search(request: SearchRequestDto) async {
        isLoading = true
        error = nil
        currentPage = 1
        results = []

        let result = await searchRepository.search(request: request)

        switch result {
        case .success(let response):
            results = response.results
            totalResults = response.numberOfResults
            hasMorePages = !response.results.isEmpty
        case .failure(let err):
            error = err.localizedDescription
        }

        isLoading = false
    }

    func loadNextPage(query: String) async {
        guard hasMorePages && !isLoading else { return }
        isLoading = true

        let result = await searchRepository.search(
            request: SearchRequestDto(query: query, pageno: currentPage + 1)
        )

        switch result {
        case .success(let response):
            results += response.results
            hasMorePages = !response.results.isEmpty
            currentPage += 1
        case .failure(let err):
            error = err.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Autocomplete

    func requestSuggestionsDebounced(query: String) {
        suggestionsTask?.cancel()
        suggestions = []
        isSuggestionsLoading = true

        suggestionsTask = Task {
            try? await Task.sleep(for: .milliseconds(500))
            guard !Task.isCancelled else { return }
            await fetchSuggestions(query: query)
        }
    }

    private func fetchSuggestions(query: String) async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            suggestions = []
            isSuggestionsLoading = false
            return
        }

        let result = await searchRepository.autocomplete(query: trimmed)

        switch result {
        case .success(let items):
            suggestions = items
        case .failure(let err):
            suggestionsError = err.localizedDescription
        }

        isSuggestionsLoading = false
    }

    func clearSuggestions() {
        suggestionsTask?.cancel()
        suggestions = []
        isSuggestionsLoading = false
        suggestionsError = nil
    }

    func clear() {
        results = []
        error = nil
        currentPage = 1
        hasMorePages = true
        totalResults = 0
        clearSuggestions()
    }
}
