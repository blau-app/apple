// OnrampView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

struct OnrampView: View {
    @State var steps = [0, 1, 2, 3]
    @State var currentStep = 1
    var totalSteps: Int {
        steps.count - 1
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                switch currentStep {
                case 0:
                    StepHeader("We are going to use Stripe to deposit money into your crypto wallet.")
                    WebViewItem(urlString: ONRAMP_STRIPE(address: "0xa53417F20BB7148a50849770471De251417C3F12"))
                        .navigationTitle("Deposit")
                case 1:
                    StepHeader("Now that you have crypto, let's stake to start earning rewards.")
                    OnrampStakeView()
                        .navigationTitle("Stake")
                case 2:
                    StepHeader("We can also lend tokens to earn rewards when other people borrow your tokens.")
                    OnrampLendView()
                        .navigationTitle("Lend")
                default:
                    StepHeader("Welcome to earning in crypto!")
                    OnrampSuccessView()
                        .navigationTitle("Success")
                }
                switch currentStep {
                case 1...:
                    VStack {
                        Progress()
                        Buttons()
                    }
                    .padding([.horizontal])
                default:
                    EmptyView()
                }
            }
            .background(Color(uiColor: UIColor.systemGroupedBackground))
        }
    }

    func StepHeader(_ text: String) -> some View {
        Text(text)
            .font(.system(.headline, design: .rounded))
            .foregroundStyle(.secondary)
            .padding([.horizontal])
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
    OnrampView()
}
