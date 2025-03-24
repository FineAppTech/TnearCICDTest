//
//  ListItemModel.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import Foundation

struct MainUI_List: Codable {
    let list_items:[ListItem]
}

struct ListItem: Identifiable, Codable {
    let id: Int
    let title: String
    let subtitle: String
    let isNavigable:Bool
}


