//
//  ProjectUpdateView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct ProjectUpdateView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .shadow(radius: 5, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Thursday, September 12, 2023")
                        .padding(.leading)
                    Spacer()
                    Text("9 Hours")
                        .padding(.trailing)
                }
                .padding(.vertical, 5)
                .background(Color("Orchid"))
                Text("Project headline")
                    .font(.smallHeadline)
                    .padding(.horizontal)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.")
                    .padding(.horizontal)
                    .padding(.bottom)
            }
             
            .foregroundStyle(.white)
            .font(.regularText)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(5)
    }
}

#Preview {
    ProjectUpdateView()
}
