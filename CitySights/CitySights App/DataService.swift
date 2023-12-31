//
//  DataService.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 23/12/2023.
//

import Foundation
import CoreLocation


struct DataService {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category: String?) async -> [Business] {
        
        // Check if api key exists (guard is like confirmation statement that something is true
        guard apiKey != nil else{
            return [Business]()
        }
        
        // Edit querys in url
        // Default lat long
        var lat = 0.0
        var long = 0.0
        
        // User lat long
        if let userLocation = userLocation {
            lat = userLocation.latitude
            long = userLocation.longitude
        }
        
        var endpointUrlString = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&limit=10"
        
        // Add query - here is example to make sure that if user hasn't entered anything the options won't be passed to get request
        if query != nil && query != "" {
            endpointUrlString.append("&term=\(String(describing: query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))")
        }
        
        // Add options - this method does not do above, I think
        if let options = options {
            endpointUrlString.append("&attributes=\(options)")
        }
        
        // Add category
        if let category = category {
            endpointUrlString.append("&categories=\(category)")
        }
        
        // 1. Create url
        if let url = URL(string: endpointUrlString) {
            
            // 2. Create request
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            // 3. Send request
            do {
                let (data, _) = try await URLSession.shared.data(for: request) // _ can be called response
                
                // 4. Parse the JSON
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                
                return result.businesses
                
            }
            catch {
                print(error)
            }
        }
        
        return [Business]()
        
    }
}
