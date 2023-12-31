//
//  ListView.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 28/12/2023.
//

import SwiftUI

struct ListView: View {
    
    @Environment(BusinessModel.self) var model
    
    var body: some View {
        List {
            ForEach(model.businesses) { b in
                VStack (spacing: 20){
                    HStack (spacing: 0) {
                        
                        
                        // Show images for restaurants
                        if let imageUrl = b.imageUrl {
                            // Display the business image, should check how to cache this for faster app and less wifi
                            AsyncImage(url: URL(string: imageUrl)!) { image in
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .padding(.trailing, 16)
                                    
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 16)
                            }
                        }
                        else {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                        }
                        
                        // Show restaurant name and distance
                        VStack (alignment: .leading, spacing: 7) {
                            Text(b.name ?? "Restaurant")
                                .font(Font.system(size: 15))
                                .bold()
                            Text(TextHelper.distanceAwayText(meters: b.distance ?? 0))
                                .font(Font.system(size: 16))
                                .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                        }
                        // Show review
                        Spacer()
                        Image("regular_\(b.rating ?? 0)")
                    }
                    Divider()
                } // select restaurant
                .onTapGesture {
                    model.selectedBusiness = b
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView()
        .environment(BusinessModel())
}
