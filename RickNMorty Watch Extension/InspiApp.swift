//
//  RickNMortyApp.swift
//  RickNMorty Watch Extension
//
//  Created by Kien on 27/01/2021.
//

import SwiftUI

@main
struct RickNMortyApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                EpisodesView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
