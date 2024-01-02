//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 31/12/2023.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        VStack {
            Image("cross")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.screenHeading)
                .foregroundStyle(Color("Olive"))
        }
        .padding()
    }
}

#Preview {
    ProjectListView()
}
