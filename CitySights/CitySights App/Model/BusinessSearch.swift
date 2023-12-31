//
//  BusinessSearch.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 27/12/2023.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var region = Region()
    var total = 0
}

struct Region: Decodable {
    var center: Coordinate?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}



//Good idea to look at JSONLint to more easily identify variables
