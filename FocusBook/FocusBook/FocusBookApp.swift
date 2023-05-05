//
//  FocusBookApp.swift
//  FocusBook
//
//  Created by 지준용 on 2023/04/24.
//

import SwiftUI

@main
struct FocusBookApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.persistentContainer.viewContext)
        }
    }
}
