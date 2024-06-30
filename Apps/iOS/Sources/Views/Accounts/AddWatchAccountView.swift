// AddWatchAccountView.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftData
import SwiftUI

struct AddWatchAccountView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.settings) private var settings
    @State var isSaveDisabled = true

    @State var name: String = ""
    @State var publicKey: String = ""

    enum FocusedField {
        case label, publicKey
    }

    @FocusState var focusedField: FocusedField?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name or ENS", text: $name)
                        .privacySensitive()
                        .focused($focusedField, equals: .label)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .onSubmit { focusedField = .publicKey }
                } header: {
                    Text("Label")
                }
                Section {
                    TextField("Public Key", text: $publicKey, axis: .vertical)
                        .monospaced()
                        .privacySensitive()
                        .focused($focusedField, equals: .publicKey)
                        .lineLimit(5 ... 5)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .onSubmit { focusedField = .label }
                } header: {
                    Text("Public Key")
                }
            }
            .onChange(of: name) { _, newValue in
                Task {
                    if newValue.isValidENSName() {
                        #if targetEnvironment(simulator)
                            let url = URL(string: "https://ens.api.blau.app/\(newValue)")!
                        #else
                            let url = URL(string: "https://ens.api.blau.app/\(newValue)")!
                        #endif
                        let (data, _) = try await URLSession.shared.data(from: url)
                        let result = try JSONDecoder().decode([String: String].self, from: data)

                        guard let ensAddress = result["publicKey"] else { return }
                        publicKey = ensAddress
                    }
                }
            }
            .navigationTitle("Add Public Account")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        settings.watch.append(Watch(name: name,
                                                    address: publicKey.noSpace))
                        dismiss()
                    }
//                    .disabled(!(!name.isEmpty && publicKey.noSpace.isPublicKeyValid()))
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Don't Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#if DEBUG
    #Preview {
        AddWatchAccountView()
    }
#endif
