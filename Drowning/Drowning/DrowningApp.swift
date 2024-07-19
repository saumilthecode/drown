//
//  DrowningApp.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import SwiftUI

@main
struct DrowningApp: App {
    @StateObject private var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeManager)
        }
    }
}
