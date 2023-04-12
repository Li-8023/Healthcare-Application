//
//  HW2App.swift
//  HW2
//
//  Created by 贺力 on 4/11/23.
//

import SwiftUI

@main
struct HW2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
