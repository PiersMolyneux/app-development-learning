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
    
    var body: some View {
        VStack {
            Text(project.name)
                .navigationBarBackButtonHidden(true)
            Button("Back") {
                dismiss()
            }
        }
    }
}

//#Preview {
//    ProjectDetailView(project: Project())
//}
