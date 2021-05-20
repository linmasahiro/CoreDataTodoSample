//
//  CoreDataTodoSampleApp.swift
//  CoreDataTodoSample
//
//  Created by CHENGHUNG on 2021/05/20.
//

import SwiftUI

@main
struct CoreDataTodoSampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
