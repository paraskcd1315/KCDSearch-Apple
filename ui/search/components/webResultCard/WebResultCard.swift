//
//  WebResultCard.swift
//  kcdsearch
//
//  Created by ParasKCD on 14/3/26.
//

import SwiftUI

struct WebResultCard: View {
    let params: WebResultCardParams

    private var result: SearchResult { params.result }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let url = result.url {
                Text(url)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            if let title = result.title {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.tint)
                    .lineLimit(2)
            }

            if let content = result.content, !content.isEmpty {
                HStack(alignment: .top, spacing: 12) {
                    if let thumbnail = result.thumbnail,
                       let thumbnailURL = URL(string: thumbnail) {
                        AsyncImage(url: thumbnailURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    Text(content)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .lineLimit(3)
                }
                .padding(.top, 4)
            }

            if let engine = result.engine {
                Text(engine)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .padding(.top, 4)
            }
        }
        .padding(.vertical, 8)
    }
}
