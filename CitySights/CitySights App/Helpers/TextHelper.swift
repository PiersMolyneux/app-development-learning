//
//  TextHelper.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 27/12/2023.
//

import Foundation

//When static, you can simply call it as the type itself

struct TextHelper {
    
    static func distanceAwayText (meters: Double) -> String {
        if meters > 1000 {
            return "\(Int(round(meters / 1000))) km away"
        }
        else {
            return "\(Int(round(meters))) m away"
        }
        
    }
}
