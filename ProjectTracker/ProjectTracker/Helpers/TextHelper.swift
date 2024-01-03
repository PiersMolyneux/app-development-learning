//
//  TextHelper.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import Foundation

struct TextHelper {
    static func convertStat(input: Double) -> String {
        
        switch (input) {
        case let stat where input > 1000:
            // Divide by 1000, replace wsith "K"
            let dividedStat = stat/1000
            return "\(round(dividedStat * 10) / 10)K"
        default:
            return String(Int(input))
        }
        
    }
    
    static func limitChars(input: String, limit: Int) -> String {
        // If the input is above the limit, take the first "limit" number of chars
        if input.count > limit {
            return String(input.prefix(limit))
        }
        return input
    }
}
