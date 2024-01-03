//
//  StatHelper.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import Foundation
import SwiftUI

struct StatHelper {
    // Method should be run after the new update has been added to projects updates array
    static func updateAdded(project: Project, update: ProjectUpdate) {
        // Change the hours
        project.hours += update.hours
        // Change wins
        if update.updateType == .milestone {
            project.wins += 1
        }
        // change sessions
        let sortedUpdates = project.updates.sorted { u1, u2 in
            u1.date > u2.date
        }
        if sortedUpdates.count >= 2 {
            let date1 = sortedUpdates[0].date
            let date2 = sortedUpdates[1].date
            if !Calendar.current.isDate(date1, inSameDayAs: date2) {
                // if not the same day, then that means latest update is first of today
                project.sessions += 1
            }
        }
        else {
            // since there are less than 2 updates, then this is the first of today
            project.sessions += 1
        }
        
    }
    // Run after update has removed project from update array
    static func updateDeleted(project: Project, update: ProjectUpdate) {
        // Change hours
        project.hours -= update.hours
        
        // Change wins
        if update.updateType == .milestone {
            project.wins -= 1
        }
        
        // change sessions
        let sameDayUpdates = project.updates.filter { u in
            Calendar.current.isDate(u.date, inSameDayAs: update.date)
        }
        if sameDayUpdates.count == 0 {
            // Means update was only update of day
            project.sessions -= 1
        }
        
    }
    
    static func updateEdited(project: Project, hoursDifference: Double) {
        // Change hours
        project.hours += hoursDifference
    }
}
