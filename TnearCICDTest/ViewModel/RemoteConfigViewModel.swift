//
//  RemoteConfigViewModel.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import FirebaseRemoteConfig
import SwiftUI

class RemoteConfigViewModel: ObservableObject {
    @Published var items: [ListItem] = []

    private var remoteConfig = RemoteConfig.remoteConfig()

    init() {
        fetchRemoteConfig()
    }

    func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // 개발 중에는 바로 업데이트되도록 설정
        remoteConfig.configSettings = settings

        remoteConfig.fetchAndActivate { status, error in
            if let error = error {
                print("RemoteConfig fetch failed: \(error.localizedDescription)")
                return
            }
            
            let jsonString = self.remoteConfig.configValue(forKey: "main_UI").stringValue
            print("jsonString is \(jsonString)")
            self.parseJSON(jsonString)
        }
    }

    private func parseJSON(_ jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else { return }
        do {
            let decodedItems = try JSONDecoder().decode(MainUI_List.self, from: data)
            DispatchQueue.main.async {
                self.items = decodedItems.list_items
            }
        } catch {
            print("JSON 파싱 오류: \(error.localizedDescription)")
        }
    }
}
