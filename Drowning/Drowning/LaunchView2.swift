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
                .foregroundColor(.black)
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
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
            
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
