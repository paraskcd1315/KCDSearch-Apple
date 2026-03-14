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

        ZStack {
            #if os(macOS)
            Rectangle.semiOpaqueWindow().padding(-1)
            #else
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            #endif
            
            VStack(spacing: 16) {
                Spacer()

                Image("KCDSearchLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)

                TextField("Search...", text: $viewModel.query)
                    .textFieldStyle(.plain)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.quaternary, lineWidth: 1)
                    )
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
            #if os(macOS)
            .frame(maxWidth: 600)
            #endif
        }
        #if os(macOS)
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        #endif
        .navigationTitle("")
    }
}
