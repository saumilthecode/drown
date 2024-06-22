//
//  SettingsView.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            
            
            Spacer()
            Divider()
                .frame(height: 2)
                .overlay(Color(.blue))
            Spacer()
            VStack(spacing: 10) {
                SettingsButton(title: "Notifications")
                SettingsButton(title: "Change Colour Mode")
                SettingsButton(title: "Shortcuts")
                SettingsButton(title: "Tutorial")
                SettingsButton(title: "Premium")
                SettingsButton(title: "Widgets")
                SettingsButton(title: "Buy us a coffee")
                SettingsButton(title: "Contact us")
            }
            Spacer()
            Divider()
                .frame(height: 2)
                .overlay(Color(.blue))
            Spacer()
            
            
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct SettingsButton: View {
    var title: String
    
    var body: some View {
        Button(action: {
            // Handle button action
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
    }
}
