//
//  HomeScreen.swift
//  kcdsearch
//
//  Created by ParasKCD on 14/3/26.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(HomeViewModel.self) private var viewModel
    @Binding var pendingQuery: String?

    var body: some View {
        @Bindable var viewModel = viewModel

        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)

            Text("KCDSearch")
                .font(.largeTitle)
                .fontWeight(.bold)

            TextField("Search...", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 32)
                .onSubmit {
                    let trimmed = viewModel.trimmedQuery()
                    if !trimmed.isEmpty {
                        pendingQuery = trimmed
                    }
                }
                #if !os(macOS)
                .textInputAutocapitalization(.never)
                #endif
                .autocorrectionDisabled()

            Spacer()
        }
    }
}
