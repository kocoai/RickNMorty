//
//  InspiApp.swift
//  Inspi Watch Extension
//
//  Created by Kien on 27/01/2021.
//

import SwiftUI

@main
struct InspiApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                EpisodesView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
