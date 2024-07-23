//
//  OnboardingView.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        TabView {
            LaunchView()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(ThemeManager())

            LaunchView2()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(ThemeManager())
        
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .ignoresSafeArea(.all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ThemeManager())

    }
}
