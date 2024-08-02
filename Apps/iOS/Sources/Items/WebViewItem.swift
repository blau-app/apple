// WebViewItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI
import WebKit

struct WebViewItem: UIViewRepresentable {
    var webView: WKWebView = .init()
    let urlString: String

    func makeUIView(context _: Context) -> WKWebView {
        guard let url = URL(string: urlString) else {
            return WKWebView()
        }
        print(url)
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}

    func reload() {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

#Preview {
    WebViewItem(urlString: "https://test.onramp.superdapp.com")
        .edgesIgnoringSafeArea(.all)
}
