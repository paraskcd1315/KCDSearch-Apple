//
//  SearchApi.swift
//  kcdsearch
//
//  Created by ParasKCD on 8/3/26.
//

import Foundation

protocol SearchApi {
    func search(request: SearchRequestDto) async throws -> SearchResultResponse
}
