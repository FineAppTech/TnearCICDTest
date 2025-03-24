//
//  TestModeListModel.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import Foundation

struct TestSection: Codable {
    let sections: [SectionModel]
}

struct SectionModel: Identifiable, Codable {
    let id = UUID()
    let title: String
    let items: [TestModeListItem]
}

struct TestModeListItem: Identifiable, Codable {
    let id: String
    let type: String // "toggle" or "navigation"
    let title: String
    let state: Bool? // "toggle" 타입일 때만 사용
    let destination: String? // "navigation" 타입일 때만 사용
}
