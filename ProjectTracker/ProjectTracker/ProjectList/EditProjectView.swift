//
//  AddProjectView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var isEditMode: Bool
    
    @State private var projectName: String = ""
    @State private var showConfirmation: Bool = false
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text(isEditMode ? "Edit Project" : "Add Project")
                    .foregroundStyle(.white)
                    .font(.bigHeadline)
                
                HStack {
                    TextField("Project name", text: $projectName)
                        .textFieldStyle(.roundedBorder)
                    // limit chars for name
                        .onChange(of: projectName) { oldValue, newValue in
                            projectName = TextHelper.limitChars(input: projectName, limit: 30)
                        }
                    Button(isEditMode ? "Save" : "Add") {
                        
                        if isEditMode {
                            // Save new project name
                            project.name = projectName
                        }
                        else {
                            // Add prtoject to SwiftData
                            project.name = projectName
                            context.insert(project)
                        }
                        dismiss() // dismisses sheet
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    
                    if isEditMode {
                        // Show delete button
                        Button("Delete") {
                            // Show confirmation dialog
                            showConfirmation = true
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                }

            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            
        }
        .confirmationDialog("Really delete?", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Yes, delete it") {
                // Delete project from SwiftData
                context.delete(project)
                dismiss() // dismisses editprojectview
            }
        }
        .onAppear {
            projectName = project.name
        }
    }
}

//#Preview {
//    AddProjectView()
//}
