//
//  MainUISwiftUIView.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import SwiftUI

struct MainUISwiftUIView: View {
    @StateObject private var viewModel = RemoteConfigViewModel()
    @State private var showPasswordPrompt = false
    @State private var isAuthenticated = false
    
    
    var body: some View {
        NavigationStack {
            List(viewModel.items) { item in
                if item.isNavigable {
                    if item.id == 3 {
#if !FIREBASE_DISTRIBUTION
                        Button(action: {
                            showPasswordPrompt = true
                        }) {
                            itemView(for: item)
                        }
                        .sheet(isPresented: $showPasswordPrompt) {
                            PasswordPromptView(isAuthenticated: $isAuthenticated)
                        }
                        .background(
                            NavigationLink(
                                destination: TestModeSwiftUIView(),
                                isActive: $isAuthenticated,
                                label: { EmptyView() }
                            )
                            .opacity(0) // 화면에 보이지 않도록 설정
                        )
                        
#else
                        itemView(for: item)
#endif
                        
                    } else {
                        NavigationLink(destination: Text("123")) {
                            itemView(for: item)
                        }
                    }
                } else {
                    itemView(for: item)
                }
            }
            .navigationTitle("Github CI/CD")
        }
    }
    
    private func itemView(for item: ListItem) -> some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.headline)
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// 비밀번호 입력창
struct PasswordPromptView: View {
    @State private var password = ""
    @Binding var isAuthenticated: Bool
    @Environment(\.dismiss) private var dismiss

    private let correctPassword = "1234" // 실제 앱에서는 보안적으로 안전한 방법 사용

    var body: some View {
        VStack {
            Text("비밀번호 입력")
                .font(.headline)
            
            SecureField("비밀번호", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("확인") {
                if password == correctPassword {
                    isAuthenticated = true
                    dismiss()
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    MainUISwiftUIView()
}
