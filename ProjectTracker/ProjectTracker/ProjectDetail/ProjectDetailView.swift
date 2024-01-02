//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    var project: Project
    
    var body: some View {
        
        ZStack {
            // Background
            LinearGradient(colors: [Color("Navy"),Color("BlueA")],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            // vertical line
            LinearGradient(colors: [Color("Washed Blue").opacity(0), Color("BlueA")], startPoint: .top, endPoint: .bottom)
                .frame(width: 1)
                .padding(.leading, -150)
            
            // Above background
            VStack {
                // Header
                VStack(alignment: .leading, spacing: 13) {
                    Text(project.name)
                        .font(.screenHeading)
                        .foregroundStyle(.white)
                    
                    HStack (alignment: .center, spacing: 13) {
                        Spacer()
                        StatBubbleView(title: "Hours", stat: "240", startColor: Color("Navy"), endColor: Color("BlueA"))
                        StatBubbleView(title: "Sessions", stat: "34", startColor: Color("GreenA"), endColor: Color("Lime"))
                        StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("PurpleA"))
                        StatBubbleView(title: "Wins", stat: "12", startColor: Color("Maroon"), endColor: Color("Olive"))
                        Spacer()
                    }
                    Text("My current focus is...")
                        .font(.featuredText)
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Design the new website")
                            .font(.featuredText)
                    }
                    .padding(.leading)

                }
                .foregroundStyle(.white)
                .padding()
                .background(Rectangle()
                    .foregroundStyle(.black)
                    .opacity(0.7)
                    .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                    .ignoresSafeArea())
                    
                
                // Project updates
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 27) {
                        ProjectUpdateView()
                        ProjectUpdateView()
                        ProjectUpdateView()
                        ProjectUpdateView()

                    }
                    .padding()
                    .padding(.bottom, 80)
                    
                }
            }
            
            // add button and bottom tray
            VStack {
                Spacer()
                HStack {
                    Button {
                        // Todo: Add project update
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 65)
                            Image("cross")
                        }
                    }
                    .padding([.leading, .top])
                    Spacer()
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .padding([.trailing, .top])
                }
                .background {
                    Color(.black)
                        .opacity(0.5)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .ignoresSafeArea()
                }
            }
            

        }
        .navigationBarBackButtonHidden(true)
    }
    
    
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
