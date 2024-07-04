//
//  LaunchView2.swift
//  Drowning
//
//  Created by Saumil Anand on 2/7/24.
//

import SwiftUI

struct LaunchView2: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Text("Welcome, Adult!")
                .font(.largeTitle)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Image(systemName: "water.waves")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
                .frame(width: 100, height: 100)
            
            Spacer()
            
            Text("Embark on a journey to keep your child safe around water.")
                .font(.title)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding()
            Text("SwimTrack functions by utilising Notifications and live activities to help you keep an eye out for your child!")
                .font(.title2)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding()
            Text("ok but whats in it for me?")
                .font(.title2)
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding()
            // make this into a navigation link soon!

            
            Spacer()
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchView2_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView2()
    }
}
