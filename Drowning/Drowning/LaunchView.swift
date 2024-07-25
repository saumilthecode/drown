//
//  LaunchView.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome to SwimTrack")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.cyan)
            
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .foregroundColor(.cyan)
            
            Text("We made this app to help protect YOUR children from ever being hurt due to distractions.")
                .font(.subheadline)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .foregroundColor(.cyan)
            
            Text("Are you an adult? Swipe right to learn more!")
                .font(.subheadline)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .foregroundColor(.mint)
            
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ThemeManager())
    }
}
