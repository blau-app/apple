// AsyncImageItem.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftUI

struct AsyncImageItem: View {
    var imageURI: String
    private let width: Double
    private let height: Double

    init(imageURI: String, width: Double = 52, height: Double = 52) {
        self.imageURI = imageURI
        self.width = width
        self.height = height
    }

    var body: some View {
        Content()
            .frame(width: width, height: height)
    }

    @ViewBuilder
    func Content() -> some View {
        switch URL(string: imageURI) {
        case let .some(url):
            AsyncImage(url: url, transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty: ProgressView()
                case let .success(image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .transition(.scale(scale: 0.1, anchor: .center))
                case let .failure(error):
//                    VStack {
                        Text(error.localizedDescription)
//                        Image(systemName: "circle.slash")
//                    }
                @unknown default:
                    EmptyView()
                }
            }
        case .none:
            Image(systemName: "circle.slash")
        }
    }
}

#Preview {
    AsyncImageItem(imageURI: "")
}
