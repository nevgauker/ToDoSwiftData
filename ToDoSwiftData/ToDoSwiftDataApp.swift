//
//  ToDoSwiftDataApp.swift
//  ToDoSwiftData
//
//  Created by Rotem Nevgauker on 28/10/2023.
//

import SwiftUI
import SwiftData

@main
struct ToDoSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Task.self)
    }
}
