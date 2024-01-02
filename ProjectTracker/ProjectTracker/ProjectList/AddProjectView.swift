//
//  AddProjectView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI
import SwiftData

struct AddProjectView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    @State var projectName: String = ""
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("New Project")
                    .foregroundStyle(.white)
                    .font(.bigHeadline)
                
                HStack {
                    TextField("Project name", text: $projectName)
                        .textFieldStyle(.roundedBorder)
                    Button("Save") {
                        project.name = projectName
                        context.insert(project)
                        dismiss() // dismisses sheet
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

//#Preview {
//    AddProjectView()
//}
