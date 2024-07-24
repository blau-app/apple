// OnboardView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct OnboardView: View {
    @State var steps = [0, 1, 2, 3]
    @State var currentStep = 0
    var totalSteps: Int {
        steps.count - 1
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                switch currentStep {
                case 0:
                    Group {
                        Label("First we need to deposit money in your wallet.",
                              systemImage: "1.circle")
                        WebViewItem(urlString: "https://onramp.superdapp.com")
                    }
                    .navigationTitle("Deposit")
                case 1:
                    Group {
                        Label("Now that you have crypto, let's stake to start earning rewards.",
                              systemImage: "2.circle")
                            .padding([.horizontal])

                        OnboardStakeView()
                    }
                    .navigationTitle("Stake")
                case 2:
                    Group {
                        Label("We can also lend tokens to earn rewards when other people borrow.",
                              systemImage: "2.circle")
                        OnboardLendView()
                    }
                    .navigationTitle("Lend")
                default:
                    VStack {
                        Text("Success, you're earning in crypto!")
                        Text("Let's check out your tokens")
                    }
                    EmptyView()
                }
                VStack {
                    Progress()
                    Buttons()
                }
                .padding()
            }
            .background(Color(uiColor: UIColor.systemGroupedBackground))
        }
    }

    func Progress() -> some View {
        ZStack(alignment: .leading) {
            Capsule(style: .continuous)
                .foregroundColor(.green)
                .frame(width: CGFloat(36 * (currentStep + 1)),
                       height: 24)
            HStack(spacing: 24) {
                ForEach(steps, id: \.self) { step in
                    Circle()
                        .foregroundColor(step > currentStep ? .secondary : .white)
                        .frame(width: 12, height: 12)
                }
            }
            .padding([.horizontal], 12)
        }
    }

    func Buttons() -> some View {
        HStack {
            if currentStep > 0 {
                Button {
                    withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
                        currentStep -= 1
                    }
                } label: {
                    Text("Back")
                }
                .foregroundColor(.secondary)
                .buttonStyle(.bordered)
            }
            Button {
                guard currentStep < totalSteps else { return }
                withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
                    currentStep += 1
                }
            } label: {
                switch currentStep {
                case totalSteps:
                    Label("Finish", systemImage: "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                default:
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .controlSize(.extraLarge)
        .font(.system(.headline, design: .rounded))
    }
}

#Preview {
    OnboardView()
}
