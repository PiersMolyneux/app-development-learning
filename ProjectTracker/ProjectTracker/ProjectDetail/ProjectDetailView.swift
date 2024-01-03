//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var project: Project
    @State private var newUpdate: ProjectUpdate? // state bc we need to change it, private as it does not need to be accessed by project list view
    @State private var showEditFocus = false
    @State private var animationOffset = 200
    
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
                        StatBubbleView(title: "Hours", stat: project.hours, startColor: Color("Navy"), endColor: Color("BlueA"))
                        StatBubbleView(title: "Sessions", stat: Double(project.sessions), startColor: Color("GreenA"), endColor: Color("Lime"))
                        StatBubbleView(title: "Updates", stat: Double(project.updates.count), startColor: Color("Maroon"), endColor: Color("PurpleA"))
                        StatBubbleView(title: "Wins", stat: Double(project.wins), startColor: Color("Maroon"), endColor: Color("Olive"))
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
                    
                
                // Project updates. If  updates then look
                if project.updates.count > 0 {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 27) {
                            
                            // This sortedArray is to produce a nice animation, it allows us to get an index
                            let sortedArray = project.updates.sorted(by: { u1, u2 in
                                u1.date > u2.date
                            })
                            
                            ForEach(Array(sortedArray.enumerated()), id: \.element) { index, update in
                                ProjectUpdateView(update: update)
                                    .offset(y: CGFloat(animationOffset)) // another animation/transition
                                    // delay start of animation (animation comes from change in animationOffset value, not below
                                    // .animation func
                                    .animation(.easeOut.delay(TimeInterval(0.05) * Double(index)), value: animationOffset)
                                
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
                
                // if no previous updates, prompt user for update
                else {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Tap to add a new project update") {
                            newUpdate = ProjectUpdate()
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(.white)
                        .padding(.bottom, 100)
                        Spacer()
                    }
                    
                    Spacer()
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
        // Another animation/transition (same one above around line 91
        .onAppear {
            withAnimation {
                animationOffset = 0
            }
        }
    }
        
    
    func completeMilestone() {
        // Create a new project update for milestone
        let update = ProjectUpdate()
        update.updateType = .milestone
        update.headline = "Milestone achieved"
        update.summary = project.focus
        project.updates.insert(update, at: 0)
        
        // Force a SwiftData save, otherwise autosave may occur after the edit, and order matters here
        try? context.save()
        
        // Update the stats
        StatHelper.updateAdded(project: project, update: update)
        
        // Clear the project focus
        project.focus = ""
    }
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
