//
//  WebViewItem.swift
//  Superdapp
//
//  Created by Joe Blau on 7/23/24.
//

import SwiftUI
import WebKit

struct WebViewItem: UIViewRepresentable {
    let urlString: String
     
     func makeUIView(context: Context) -> WKWebView {
         guard let url = URL(string: urlString) else {
             return WKWebView()
         }
         let request = URLRequest(url: url)
         let webView = WKWebView()
         webView.load(request)
         return webView
     }
     
     func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    WebViewItem(urlString: "https://onramp.superdapp.com")
        .edgesIgnoringSafeArea(.all)
}
