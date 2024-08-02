// SignInView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct SignInView: View {
    @State private var scrollOffset: CGFloat = 0
    @Environment(\.auth) private var auth

    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image("hero")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -scrollOffset / 2) // Parallax effect
                    .clipped()
                    .overlay(
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0.44),
                                .init(color: Color(uiColor: .systemBackground), location: 0.66),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .ignoresSafeArea()
            VStack {
                Spacer()
                if let appIcon = UIImage.appIcon {
                    Image(uiImage: appIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(.tertiary, lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                }
                TitleSubtitle()
                Actions()
            }
        }
    }

    @ViewBuilder
    private func TitleSubtitle() -> some View {
        VStack(spacing: 10) {
            Text("Welcome to Superdapp")
                .multilineTextAlignment(.center)
                .font(.system(size: 42, weight: .bold, design: .serif))
            Text("Access to crypto in one easy to use expereince")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.system(.headline, design: .rounded))
        }
        .padding()
    }

    @ViewBuilder
    private func Actions() -> some View {
        VStack(spacing: 10) {
            Button {} label: {
                Label("Sign In With Face ID", systemImage: "faceid")
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            Text("Your privacy is our prioirty. You are the only person who has access to your private keys.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.system(.caption, design: .rounded))
        }
        .padding()
    }
}

#Preview {
    SignInView()
}
