//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    // private as only needs to be used in ProjectListView and children of ProjectListView
    @State private var newProject: Project?
    @Query private var projects: [Project]
    
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
                        ForEach(projects) { p in
                            ProjectCardView(project: p)
                        }
                        
                    }
                }
                


            }
            .padding()
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        self.newProject = Project()
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
        .sheet(item: $newProject) { project in
            AddProjectView(project: project)
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    ProjectListView()
}
