//
//  LaunchView.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var themeManager:ThemeManager

    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome to SwimTrack")
                .font(.title)
                .foregroundColor(.cyan)
            Spacer()
                
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.cyan)
                .font(.largeTitle)
                
            Spacer()
                
            Text("We made this app to help protect YOUR children from ever being hurt due to distractions.")
                .font(.subheadline)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.cyan)
                
            Text("Are you an adult? Swipe right to learn more!")
                .font(.subheadline)
                .foregroundColor(.cyan)
                
            Spacer()
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing
                                  )
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
