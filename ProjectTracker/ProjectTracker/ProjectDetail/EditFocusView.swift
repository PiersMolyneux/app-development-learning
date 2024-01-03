//
//  EditFocusView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 03/01/2024.
//

import SwiftUI

struct EditFocusView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    @State var focus: String = ""
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("Edit Project Focus")
                    .foregroundStyle(.white)
                    .font(.bigHeadline)
                
                HStack {
                    TextField("Focus", text: $focus)
                        .textFieldStyle(.roundedBorder)
                    Button("Save") {
                        // Save focus of project, automatically gets saves
                        project.focus = focus
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
//    EditFocusView()
//}
