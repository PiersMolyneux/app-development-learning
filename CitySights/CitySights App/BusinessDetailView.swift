//
//  BusinessDetailView.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 27/12/2023.
//

import SwiftUI

struct BusinessDetailView: View {
    
    @Environment(BusinessModel.self) var model
    
    var body: some View {
        
        let business = model.selectedBusiness
        
        VStack (alignment: .leading, spacing: 0) {
            
            ZStack(alignment: .trailing) {
                
                // Business image supplied by api, if not existing then default
                if let imageUrl = business?.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(height: 164)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                }
                else {
                    Image("detail-placeholder-image")
                        .resizable()
                }
                
                // Yelp overlay image
                VStack {
                    Spacer()
                    Image("yelp-attribution-image")
                        .frame(width: 71, height: 36)
                }
            }
            .frame(height: 164)
            
            
            // Show if business is closed or open
            if let isClosed = business?.isClosed {
                ZStack (alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(isClosed ? .red : .green)
                    Text(isClosed ? "Closed" : "Open")
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                }
                .frame(height: 36)
            }
            
            // Scrollview for whole thing
            ScrollView {
                // Business Name, address, and rating
                VStack (alignment: .leading, spacing: 0) {
                    Text(business?.name ?? "")
                        .font(Font.system(size: 21))
                        .bold()
                        .padding(.bottom, 10)
                        .padding(.top, 16)
                    Text("\(business?.location?.address1 ?? ""), \(business?.location?.city ?? "")")
                    Text("\(business?.location?.state ?? "") \(business?.location?.zipCode ?? ""), \(business?.location?.country ?? "")")
                        .padding(.bottom, 10)
                    
                    Image("regular_\(business?.rating ?? 0)")
                        .padding(.bottom, 16)
                    
                    Divider()
                    
                    // Business phone number
                    HStack {
                        Image(systemName: "phone")
                        if let url = URL(string: "tel:\(business?.phone ?? "")") {
                            Link(destination: url, label: {
                                Text(business?.phone ?? "")
                            })
                        }
                        else {
                            Text(business?.phone ?? "")
                        }
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                    
                    Divider()
                        .padding(.top, 12)
                    
                    // Business URL
                    HStack {
                        Image(systemName: "globe")
                        if let url = URL(string: "http:\(business?.url ?? "")") {
                            Link(destination: url, label: {
                                Text(business?.url ?? "")
                                    .lineLimit(1)
                            })
                        }
                        else {
                            Text(business?.url ?? "")
                                .lineLimit(1)
                        }
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                    
                    Divider()
                        .padding(.top, 12)
                    
                    
                    // Business Review count
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("\(business?.reviewCount ?? 0) reviews")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding(.top, 12)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    BusinessDetailView()
        .environment(BusinessModel())
}
