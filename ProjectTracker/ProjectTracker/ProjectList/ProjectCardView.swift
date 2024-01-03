//
//  ProjectCardView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct ProjectCardView: View {
    
    var project: Project
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.7)
                .shadow(radius: 5, x: 0, y: 4)
            VStack(alignment: .leading, spacing: 10) {
                Text(project.name)
                    .font(Font.bigHeadline)
                    .foregroundStyle(.white)
                    
                HStack (alignment: .center, spacing: 13) {
                    Spacer()
                    StatBubbleView(title: "Hours", stat: "240", startColor: Color("Navy"), endColor: Color("BlueA"))
                    StatBubbleView(title: "Sessions", stat: "34", startColor: Color("GreenA"), endColor: Color("Lime"))
                    StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("PurpleA"))
                    StatBubbleView(title: "Wins", stat: "12", startColor: Color("Maroon"), endColor: Color("Olive"))
                    Spacer()

                }
                
                if (project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                    
                    Text("My current focus is...")
                        .font(.featuredText)
                        .foregroundStyle(.gray)
                    Text(project.focus)
                        .font(.featuredText)
                        .foregroundStyle(.gray)
                        .bold()
                    
                }

            }
            .padding()
        }
    }
}

#Preview {
    ProjectCardView(project: Project())
}
