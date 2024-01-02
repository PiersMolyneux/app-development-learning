//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color("Deep Purple"), Color("Blush Pink")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack (alignment: .leading){
                Text("Projects")
                    .font(Font.screenHeading)
                    .foregroundStyle(Color.white)
                
                ScrollView (showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        ProjectCardView()
                        ProjectCardView()
                        ProjectCardView()
                    }
                }
                


            }
            .padding()
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        // To Do
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 65)
                                .foregroundColor(.black)
                            Image("cross")
                        }
                    }
                    Spacer()
                }
            }
            .padding(.leading)
            
            
        }
    }
}

#Preview {
    ProjectListView()
}
