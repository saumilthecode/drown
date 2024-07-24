//
//  SettingsView.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

//
//  SettingsView.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @EnvironmentObject private var themeManager:ThemeManager

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    SettingsButton(title: "Notifications", action: openNotificationSettings)
                    
                    NavigationLink(destination: SheetItemView()) {
                        Text("Change Colour Mode")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(25)
                            .padding(.horizontal, 20)
                    }
                    
                    SettingsButton(title: "Shortcuts", action: {})
                }
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing
                                      )
            )
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
    
    func openNotificationSettings() {
        if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

struct SettingsButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(25)
                .padding(.horizontal, 20)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ThemeManager())

    }
}
