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
    @State private var newUpdate: ProjectUpdate? // state bc we need to change it, private as it does not need to be accessed by project list view
    @State private var showEditFocus = false
    
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
                        if (project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                            Button {
                                // Complete this milestone
                                completeMilestone()
                            } label: {
                                Image(systemName: "checkmark.square")
                            }
                        }
                        
                        // If empty show default, otherwise show project focus
                        Text(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Tap to set your focus" : project.focus)
                            .font(.featuredText)
                            .onTapGesture {
                                // Display the edit focus form
                                showEditFocus = true
                            }
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
                        ForEach(project.updates.sorted(by: { u1, u2 in
                            u1.date > u2.date
                        })) { update in
                            ProjectUpdateView(update: update)
                            // add ontap gesture so tap gets captured and screen knows we are scrolling, otherwise we cannot use scroll view
                                .onTapGesture {
                                }
                            // edit project update by setting update to existing update so it knows there has been a changed
                                .onLongPressGesture {
                                    newUpdate = update
                                }
                        }

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
                        newUpdate = ProjectUpdate()
                        
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
        .sheet(item: $newUpdate) { update in
            
            let isEdit = update.headline.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditUpdateView(project: project, update: update, isEditMode: isEdit)
                .presentationDetents([.fraction(0.3)])
        }
        .sheet(isPresented: $showEditFocus, content: {
            EditFocusView(project: project)
                .presentationDetents([.fraction(0.2)])
        })
    }
    
    func completeMilestone() {
        // Create a new project update for milestone
        let update = ProjectUpdate()
        update.updateType = .milestone
        update.headline = "Milestone achieved"
        update.summary = project.focus
        project.updates.insert(update, at: 0)
        // Clear the project focus
        project.focus = ""
    }
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
