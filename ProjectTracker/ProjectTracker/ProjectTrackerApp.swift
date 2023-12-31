//
//  ProjectTrackerApp.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import SwiftUI
import SwiftData

@main
struct ProjectTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .modelContainer(for: [Project.self, ProjectUpdate.self])
        }
    }
}
