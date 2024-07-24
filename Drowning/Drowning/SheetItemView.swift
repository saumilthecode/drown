//
//  SheetItemView.swift
//  Theme_Switcher_SwiftUI
//
//  Created by Haaris Iqubal on 2/18/22.
//

import SwiftUI

struct SheetItemView: View {
    
    @EnvironmentObject private var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            themeManager.selectedTheme.secondaryColor.ignoresSafeArea(.all)
            VStack(spacing: 16) { // Added spacing between buttons
                ForEach(0..<themeManager.themes.count) { themeCount in
                    Button(action: {
                        withAnimation {
                            themeManager.applyTheme(themeCount)
                        }
                    }, label: {
                        Text("Change \(themeManager.themes[themeCount].themeName)")
                            .font(.headline) // Enhanced font style
                            .padding() // Added padding
                            .frame(maxWidth: .infinity) // Full width button
                            .background(themeManager.themes[themeCount].primaryColor) // Button background color based on theme
                            .foregroundColor(.white) // Text color
                            .cornerRadius(10) // Rounded corners
                            .shadow(radius: 120) // Added shadow for depth
                    })
                }
                .buttonStyle(PlainButtonStyle()) // Using PlainButtonStyle for custom styling
            }
            .padding() // Added padding around the VStack
        }
    }
}

struct SheetItemView_Previews: PreviewProvider {
    static var previews: some View {
        SheetItemView()
            .environmentObject(ThemeManager()) // Added environment object for preview
    }
}
