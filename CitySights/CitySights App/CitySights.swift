//
//  CitySights_AppApp.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 23/12/2023.
//

import SwiftUI

@main
struct CitySights: App {
    
    @State var model = BusinessModel()
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(BusinessModel())
            // now add OnboardingView
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(model) // needs to pass business model to onboarding view so we can request permission
                }
                .onAppear {
                    // of no onboarding is needed, still get location
                    if needsOnboarding == false && model.locationAuthStatus == .notDetermined {
                        model.getUserLocation()
                    }
                }
        }
    }
}
