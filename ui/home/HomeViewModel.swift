//
//  HomeViewModel.swift
//  kcdsearch
//
//  Created by ParasKCD on 9/3/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    private let searchService = SearchService.shared

    var query: String = ""

    var isLoading: Bool { searchService.isLoading }
    var error: String? { searchService.error }

    func trimmedQuery() -> String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func clear() {
        query = ""
        searchService.clear()
    }
}
