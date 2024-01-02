//
//  FontHelper.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import Foundation
import SwiftUI

// Want to extend existing swiftui structure

extension Font {
    
    // static allows use of property/method without creating instance of it first
    static var screenHeading = Font.system(size: 36, weight: .bold)
    static var bigHeadline = Font.system(size: 15, weight: .bold)
    static var smallHeadline = Font.system(size: 10, weight: .bold)
    static var featuredNumber = Font.system(size: 18)
    static var featuredText = Font.system(size: 12)
    static var regularText = Font.system(size: 10)
    static var captionText = Font.system(size: 8)
    
    
}
