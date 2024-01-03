//
//  StatBubbleView.swift
//  ProjectTracker
//
//  Created by Molyneux, Piers on 02/01/2024.
//

import SwiftUI

struct StatBubbleView: View {
    
    var title: String
    var stat: Double
    var startColor: Color
    var endColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    colors: [Color(startColor), Color(endColor)], 
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
            VStack {
                Text(title)
                    .font(.captionText)
                Text(TextHelper.convertStat(input: stat))
                    .contentTransition(.numericText()) // another transition/animation
                    .font(.featuredNumber)
                    .bold()
            }
            .foregroundStyle(.white)
        }
        .frame(width: 60, height: 40)
    }
}

#Preview {
    StatBubbleView(title: "Hours", stat: 290, startColor: Color("Navy"), endColor: Color("Blue"))
}
