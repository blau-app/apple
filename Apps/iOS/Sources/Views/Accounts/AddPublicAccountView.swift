// AddPublicAccountView.swift
// Copyright (c) 2024 Party Labs, Inc

import SwiftData
import SwiftUI

// struct AddPublicAccountFeature: Reducer {
//    struct State: Equatable {
//        @BindingState var focus: Field? = .label
//        @BindingState var isFormInvalid = true
//        @BindingState var name: String = ""
//        @BindingState var publicKey: String = ""
//

//    }
//
//    enum Action: BindableAction, Equatable {
//        case binding(BindingAction<State>)
//        case onAppear
//        case setFocus(State.Field)
//        case setAddress(String)
//        case isFormValid
//    }
//
//    var body: some ReducerOf<Self> {
//        BindingReducer()
//        Reduce<State, Action> { state, action in
//            switch action {
//            case .onAppear:
//                state.focus = .label
//                return .none
//
//            case let .setFocus(field):
//                state.focus = field
//                return .none
//
//            case .binding(\.$name):
//                let label = state.name
//                return .run { send in
//                    if label.isValidENSName() {
//                        #if targetEnvironment(simulator)
//                            let url = URL(string: "http://localhost:3000/api/ens/\(label)")!
//                        #else
//                            let url = URL.partyLabsTellerENS(ensName: label)!
//                        #endif
//                        let (data, _) = try await urlSession.data(from: url)
//                        let result = try decode([String: String].self, from: data)
//
//                        guard let ensAddress = result["ensAddress"]?.splitPublicKey() else { return }
//                        await send(.setAddress(ensAddress))
//                    } else {
//                        await send(.isFormValid)
//                    }
//                }
//            case .binding(\.$publicKey):
//                return .send(.isFormValid)
//
//            case let .setAddress(publicKey):
//                state.publicKey = publicKey
//                return .send(.isFormValid)
//
//            case .isFormValid:
//                let isValid = !state.name.isEmpty && state.publicKey.isPublicKeyValid()
//                state.isFormInvalid = !isValid
//                return .none
//
//            case .binding:
//                return .none
//            }
//        }
//    }
//
//    @Dependency(\.decode) var decode
//    @Dependency(\.urlSession) var urlSession
// }

struct AddPublicAccountView: View {
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
                        settings.publicAccounts.append(PublicAccount(name: name,
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
        AddPublicAccountView()
    }
#endif
