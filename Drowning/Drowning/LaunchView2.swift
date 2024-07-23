
//
//  LaunchView2.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct LaunchView2: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome, Adult!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding()
            
            Image(systemName: "water.waves")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("Embark on a journey to keep your child safe around water.")
                .font(.title2)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("SwimTrack functions by utilizing Notifications and live activities to help you keep an eye out for your child!")
                .font(.title3)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("What's in it for me?")
                .font(.title3)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
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

struct LaunchView2_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView2()
            .environmentObject(ThemeManager())
    }
}
