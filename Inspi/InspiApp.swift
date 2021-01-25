//
//  InspiApp.swift
//  Inspi
//
//  Created by Kien on 25/01/2021.
//

import SwiftUI

@main
struct InspiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
