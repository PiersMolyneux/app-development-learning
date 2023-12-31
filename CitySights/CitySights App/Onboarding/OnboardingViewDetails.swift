//
//  OnboardingViewDetails.swift
//  CitySights App
//
//  Created by Molyneux, Piers on 29/12/2023.
//

import SwiftUI

struct OnboardingViewDetails: View {
    
    var bgColor: Color
    var headline: String
    var subHeadline: String
    var buttonAction: () -> Void // function data type that returns void
    
    var body: some View {
        ZStack {
            Color(bgColor)
            VStack(spacing: 0) {
                Spacer()
                Spacer()
                Image("onboarding")
                    .padding()
                
                Text(headline)
                    .font(Font.system(size: 22))
                    .bold()
                
                Text(subHeadline)
                    .padding(.top, 4)
                Spacer()
                
                Button {
                    buttonAction()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .foregroundColor(.white)
                            .frame(height: 50)
                        Text("Continue")
                            .foregroundColor(.black)
                            .bold()
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 115)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    OnboardingViewDetails(bgColor: Color(red: 111/255, green: 154/255, blue: 189/255), headline:  "Welcome to City Sights", subHeadline: "City Sights helps you find the best of the city!") {
        // Nothing
    }
}
