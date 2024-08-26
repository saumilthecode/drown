//
//  LaunchView.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct LaunchView: View {
    // Access the theme manager to use theme colors
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        VStack {
            Spacer() // Adds space at the top
            
            // Main Title
            Text("Welcome to SwimTrack")
                .font(.largeTitle)
                .fontWeight(.thin)
                .foregroundColor(themeManager.selectedTheme.primaryColor) // Dynamic color
                .padding(.top, 50) // Top padding
                .shadow(color: .blue.opacity(0.4), radius: 4, x: 0, y: 2) // Shadow effect
            
            // Swimming Icon
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180) // Icon size
                .foregroundColor(themeManager.selectedTheme.primaryColor).opacity(0.9) // Dynamic color with opacity
                .padding(.vertical, 20) // Vertical padding
                .shadow(color: .blue.opacity(0.4), radius: 4, x: 0, y: 2) // Shadow effect
            
            // Informative Text
            Text("""
                SwimTrack is your ultimate companion for ensuring the safety and focus of your loved ones. Our app is designed to help protect children from potential distractions while they swim. Join us in making swimming a safer experience!
                """)
            .font(.system(size: 18, weight: .medium, design: .default)) // Medium weight font
            .padding(.horizontal, 30) // Horizontal padding
            .multilineTextAlignment(.center) // Centered text
            .foregroundColor(.black) // Static text color (consider using dynamic color)
            
            Spacer()
            
            // Call to Action
            Text("Are you an adult? Swipe right to learn more!")
                .font(.subheadline) // Medium weight font
                .padding(.horizontal, 30) // Horizontal padding
                .multilineTextAlignment(.center) // Centered text
                .foregroundColor(themeManager.selectedTheme.labelColor) // Dynamic color
                .padding(.bottom, 50) // Bottom padding
            
            Spacer() // Adds space at the bottom
        }
        .padding() // Overall padding
        .background(
            LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing) // Background gradient
        )
        .edgesIgnoringSafeArea(.all) // Extend background to cover safe area
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ThemeManager())
    }
}
