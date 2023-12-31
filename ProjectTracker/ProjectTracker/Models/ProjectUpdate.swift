//
//  ProjectUpdate.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import Foundation
import SwiftData

@Model
class ProjectUpdate: Identifiable {
    
    @Attribute(.unique) var id: String
    var headline = ""
    var summary = ""
    var date = Date()
    var hours = 0.0
    var updateType = UpdateType.log
    var project: Project?
    
    init() {
        id = UUID().uuidString
    }
}

// Codable also with json - allows to be serialized and de-serialized
enum UpdateType: Codable {
    case log
    case milestone
}
