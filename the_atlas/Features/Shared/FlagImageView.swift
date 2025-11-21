//
//  FlagImageView.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-21.
//

import SwiftUI

struct FlagImageView: View {
    let url: URL?
    
    init(urlPath: String) {
        self.url = URL(string: urlPath)
    }
    
    init(url: URL?) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Color(white: 8.8)
                    .overlay {
                        ProgressView()
                            .controlSize(.large)
                    }
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .clipped()
            case .failure(_):
                Text("Could not load image")
            @unknown default:
                fatalError()
            }
        }
    }
}
