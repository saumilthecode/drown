//
//  DrowningApp.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import SwiftUI
import TipKit

@main
struct DrowningApp: App {
    @StateObject private var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeManager)
        }
    }
    init() {
        do {
            // Configure and load all tips in the app.
            try Tips.configure()
            print("inititalize")
        }
        catch {
            print("Error initializing tips: \(error)")
        }
    }
}
