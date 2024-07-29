// SendView.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

enum AddressLoad: Identifiable {
    var id: Self { self }
    case addressBook
    case qr
}

struct SendView: View {
    @State var presentedAddressLoad: AddressLoad?
    @State var destinationAddress: String = ""

    var body: some View {
        Form {
            Section {
                TextField("Destination",
                          text: $destinationAddress,
                          prompt: Text("0x..."),
                          axis: .vertical)
                    .lineLimit(5 ... 5)
            } header: {
                Text("Destination Address")
            }

            NavigationLink {
//                AuthenticateView(serviceAction: $serviceAction,
//                                 slippage: 0.01,
//                                 blockNumber: 17856820,
//                                 fee: Fee())
            } label: {
                Text("Send").frame(maxWidth: .infinity,
                                   alignment: .center)
                    .foregroundColor(.accentColor)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {}, label: {
                    Label("Address Book", systemImage: "person.crop.square.filled.and.at.rectangle")
                }).disabled(true)
                Button(action: { scanAddress() }, label: {
                    Label("Scan QR", systemImage: "qrcode.viewfinder")
                })
                Button { pasteAddress() } label: {
                    Label("Paste", systemImage: "list.clipboard")
                }
            }
        }
        .sheet(item: $presentedAddressLoad) { addressLoad in
            switch addressLoad {
            case .addressBook: EmptyView()
            case .qr:
                #if targetEnvironment(simulator)
                    NoSimulatorFunctionalityItem()
                #else
                    QRCodeScannerItem(scannedCode: $destinationAddress,
                                      presentedAddressLoad: $presentedAddressLoad)

                #endif
            }
        }
    }

    private func scanAddress() {
        presentedAddressLoad = .qr
    }

    private func pasteAddress() {
        guard let address = UIPasteboard.general.string else {
            print("Invalid address")
            return
        }
        destinationAddress = address
    }
}

#Preview {
    SendView()
}
