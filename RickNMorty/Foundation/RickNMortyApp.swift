//
//  RickNMortyApp.swift
//  RickNMorty
//
//  Created by Kien on 25/01/2021.
//

import SwiftUI

@main
struct RickNMortyApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                EpisodesView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
