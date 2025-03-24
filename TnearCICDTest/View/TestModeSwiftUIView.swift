//
//  TestModeSwiftUIView.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import SwiftUI
import FirebaseRemoteConfig

struct TestModeSwiftUIView: View {
    @StateObject private var viewModel = TestModeRemoteConfigViewModel()
    @State private var toggleStates: [String: Bool] = [:]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sections) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.items) { item in
                            switch item.type {
                            case "toggle":
                                Toggle(item.title, isOn: Binding(
                                    get: { toggleStates[item.id] ?? item.state ?? false },
                                    set: { toggleStates[item.id] = $0 }
                                ))
                            case "navigation":
                                NavigationLink(destination: Text(item.title)) {
                                    Text(item.title)
                                }
                            default:
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Test Mode")
        }
    }
}

#Preview {
    TestModeSwiftUIView()
}
