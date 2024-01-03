//
//  DateHelper.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import Foundation

struct DateHelper {
    static func convertProjectUpdateDate(inputDate: Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        return df.string(from: inputDate)
    }
}
