//
//  ProjectUpdateView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct ProjectUpdateView: View {
    
    var update: ProjectUpdate
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .shadow(radius: 5, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(DateHelper.convertProjectUpdateDate(inputDate: update.date))
                        .padding(.leading)
                    Spacer()
                    Text("\(Int(update.hours)) Hours")
                        .padding(.trailing)
                }
                .padding(.vertical, 5)
                .background(Color("Orchid"))
                Text(update.headline)
                    .font(.smallHeadline)
                    .padding(.horizontal)
                
                Text(update.summary)
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

//#Preview {
//    ProjectUpdateView()
//}
