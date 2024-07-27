// WebViewItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI
import WebKit

struct WebViewItem: UIViewRepresentable {
    let urlString: String

    func makeUIView(context _: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}

#Preview {
    WebViewItem(urlString: "https://onramp-preview.superdapp.com")
        .edgesIgnoringSafeArea(.all)
}
