//
//  Project.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
    
    @Attribute(.unique) var id: String
    var name = ""
    var startDate = Date()
    var focus = ""
    @Relationship(deleteRule: .cascade, inverse: \ProjectUpdate.project)
    var updates: [ProjectUpdate] = [ProjectUpdate]()
    var hours: Double = 0
    var sessions: Int = 0
    var wins: Int = 0
    
    init() {
        id = UUID().uuidString
    }
}
