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
        VStack {
            Spacer()

            // Main Title
            Text("Welcome to SwimTrack")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(themeManager.selectedTheme.primaryColor)
                .padding(.top, 50)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)

            // Swimming Icon
            Image(systemName: "figure.pool.swim")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(themeManager.selectedTheme.primaryColor).opacity(0.9)
                .padding(.vertical, 20)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)

            // Informative Text
            Text("""
                SwimTrack is your ultimate companion for ensuring the safety and focus of your loved ones. Our app is designed to help protect children from potential distractions while they swim. Join us in making swimming a safer experience!
                """)
                .font(.system(size: 18, weight: .medium, design: .default))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                .foregroundColor(.black) // Use dynamic text color

            // Call to Action
            Text("Are you an adult? Swipe right to learn more!")
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

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ThemeManager())
    }
}
