//
//  AddUpdateView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import SwiftUI

struct AddUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var update: ProjectUpdate
    
    @State private var headline: String = ""
    @State private var summary: String = ""
    @State private var hours: String = ""
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("New Update")
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
                    
                    Button("Save") {
                        // Save project update
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)! // force unwrap bc should be able to convert
                        project.updates.insert(update, at: 0)
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
                

                
                
            }
            .padding(.horizontal)
            .padding(.top)
            Spacer()
            
        }
    }
}
//
//#Preview {
//    AddUpdateView(project: Project())
//}
