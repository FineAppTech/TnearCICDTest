//
//  TestModeRemoteConfigViewModel.swift
//  TnearCICDTest
//
//  Created by Taewook Noh on 3/18/25.
//

import Foundation
import FirebaseRemoteConfig

class TestModeRemoteConfigViewModel: ObservableObject {
    @Published var sections: [SectionModel] = []

     private var remoteConfig = RemoteConfig.remoteConfig()

     init() {
         fetchRemoteConfig()
     }

     func fetchRemoteConfig() {
         let settings = RemoteConfigSettings()
         settings.minimumFetchInterval = 0
         remoteConfig.configSettings = settings

         remoteConfig.fetchAndActivate { status, error in
             if let error = error {
                 print("RemoteConfig fetch failed: \(error.localizedDescription)")
                 return
             }
             
             let jsonString = self.remoteConfig.configValue(forKey: "TestMode_UI").stringValue
             print("jsonString is that \(jsonString)")
             self.parseJSON(jsonString)

         }
     }

     private func parseJSON(_ jsonString: String) {
         guard let data = jsonString.data(using: .utf8) else { return }
         do {
             let decodedSections = try JSONDecoder().decode(TestSection.self, from: data)
             DispatchQueue.main.async {
                 self.sections = decodedSections.sections
             }
         } catch {
             print("JSON 파싱 오류: \(error.localizedDescription) \(error)")
         }
     }
 }
