//
//  AddUpdateView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import SwiftUI

struct EditUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var update: ProjectUpdate
    var isEditMode: Bool
    
    @State private var headline: String = ""
    @State private var summary: String = ""
    @State private var hours: String = ""
    @State private var showConfirmation = false
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text(isEditMode ? "Edit Update" : "New Update")
                    .foregroundStyle(.white)
                    .font(.bigHeadline)
                
                
                TextField("Headline", text: $headline)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Summary", text: $summary, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    
                    TextField("Hours", text: $hours)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                    
                    // Do updates
                    Button(isEditMode ? "Save" : "Add") {
                        
                        // Edit or save updates
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)! // force unwrap bc should be able to convert
                        // edit project update
                        if !isEditMode {
                            // Add project update if not edit mode
                            project.updates.insert(update, at: 0)
                        }
                        dismiss()
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    // Add delete button if editmode
                    if isEditMode {
                        Button("Delete") {
                            // Show confirmation dialog
                            showConfirmation = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
                

                
                
            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            
        }
        .confirmationDialog("Really delete the update?", isPresented: $showConfirmation) {
            Button("Yes, delete it") {
                // Search for the update in update list by its id, remove all updates with same id (should be unique)
                project.updates.removeAll { u in
                    u.id == update.id
                }
                dismiss()
            }
            
        }
        .onAppear {
            headline = update.headline
            summary = update.summary
            hours = String(Int(update.hours))
            
        }
    }
}
//
//#Preview {
//    AddUpdateView(project: Project())
//}
