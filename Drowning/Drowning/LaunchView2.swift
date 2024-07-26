
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
        VStack {
            Spacer()
            
            // Main Title
            Text("Welcome, Adult!")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(themeManager.selectedTheme.primaryColor)
                .padding(.top, 50)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            
            // Water Waves Icon
            Image(systemName: "water.waves")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(themeManager.selectedTheme.primaryColor.opacity(0.9))
                .padding(.vertical, 20)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            
            // Informative Text
            Text("""
                Embark on a journey to keep your child safe around water. SwimTrack functions by utilizing Notifications and live activities to help you keep an eye out for your child!
                """)
            .font(.system(size: 18, weight: .medium, design: .default))
            .padding(.horizontal, 30)
            .multilineTextAlignment(.center)
            .foregroundColor(.black) // Consider using dynamic color
            
            // Call to Action
            Text("What's in it for me?")
                .font(.system(size: 18, weight: .medium, design: .default))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .foregroundColor(themeManager.selectedTheme.labelColor)
                .padding(.bottom, 50)
            
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
