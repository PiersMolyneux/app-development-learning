//
//  MapView.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 28/12/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(BusinessModel.self) var model
    @State var selectedBusinessId: String? // string bc business id is  astring
    
    var body: some View {
        // binding as user also interacts with it
        Map(selection: $selectedBusinessId) {
            ForEach(model.businesses, id: \.id) {b in
                Marker(b.name ?? "Restaurant",
                       coordinate: CLLocationCoordinate2D(latitude: b.coordinates?.latitude ?? 0,
                                              longitude: b.coordinates?.longitude ?? 0))
                .tag(b.id ?? "None") // we tag with id instead of name - unique. if there is no id, then select to none
            }
        }
        .onChange(of: selectedBusinessId) { oldValue, newValue in
            // Find business which matches this. .first goes through business list to find
            let business = model.businesses.first { business in
                business.id == selectedBusinessId
            }
            
            // if business is found, select it as the selected one (basically unwrap to see if business exists, if does then select
            if let business = business {
                model.selectedBusiness = business
            }
            
        }
    }
}

#Preview {
    MapView()
        .environment(BusinessModel())
}
