//
//  MainUISwiftUIView.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import SwiftUI

struct MainUISwiftUIView: View {
    @StateObject private var viewModel = RemoteConfigViewModel()

    var body: some View {
        
        NavigationStack {
            List(viewModel.items) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Github CI/CD")
        }
//        NavigationView {
//
//        }
    }
}

#Preview {
    MainUISwiftUIView()
}
