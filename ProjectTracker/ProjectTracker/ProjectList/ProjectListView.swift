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
    @State private var selectedProject: Project?
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Deep Purple"), Color("Blush Pink")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack (alignment: .leading){
                    Text("Projects")
                        .font(Font.screenHeading)
                        .foregroundStyle(Color.white)
                    
                    
                    // If there are already projects
                    if projects.count > 0 {
                        ScrollView (showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 26) {
                                ForEach(projects) { p in
                                    ProjectCardView(project: p)
                                        .onTapGesture {
                                            // Change sleected project, triggers .navigationDestination bellow
                                            selectedProject = p
                                        }
                                    // Long press to delete
                                        .onLongPressGesture {
                                            newProject = p
                                        }
                                    
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    
                    // If no projects
                    else {
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Tap to add a new project") {
                                newProject = Project()
                            }
                            .buttonStyle(.bordered)
                            .foregroundStyle(.white)
                            Spacer()
                        }
                        
                        Spacer()
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
            .navigationDestination(item: $selectedProject, destination: { project in
                ProjectDetailView(project: project)
            })
        }
        .sheet(item: $newProject) { project in
            
            
            // If project has a name then editmode is true
            let isEdit = project.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditProjectView(project: project, isEditMode: isEdit)
                .presentationDetents([.fraction(0.2)])
        }
    }
}

#Preview {
    ProjectListView()
}
