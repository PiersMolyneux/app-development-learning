//
//  ProjectCardView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct ProjectCardView: View {
    
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.7)
                .shadow(radius: 5, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 10) {
                Text("CodeWithPiers")
                    .font(Font.bigHeadline)
                    .foregroundStyle(.white)
                    
                HStack (alignment: .center, spacing: 13) {
                    Spacer()
                    StatBubbleView(title: "Hours", stat: "240", startColor: Color("Navy"), endColor: Color("Blue"))
                    StatBubbleView(title: "Sessions", stat: "34", startColor: Color("Green"), endColor: Color("Lime"))
                    StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("Purple"))
                    StatBubbleView(title: "Wins", stat: "12", startColor: Color("Maroon"), endColor: Color("Olive"))
                    Spacer()

                }
                Text("My current focus is...")
                    .font(.featuredText)
                    .foregroundStyle(.gray)
                Text("Design the new website")
                    .font(.featuredText)
                    .foregroundStyle(.gray)
            }
            .padding()
        }
    }
}

#Preview {
    ProjectCardView()
}
