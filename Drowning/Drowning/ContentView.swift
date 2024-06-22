//
//  ContentView.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var interval: Double = 30 // Default interval in seconds
    @State private var isStarted: Bool = false
    
    var body: some View {
        VStack {
            Text("Drown Saver")
                .font(.largeTitle)
                .padding()
            
            Text("Set Interval (seconds)")
            Slider(value: $interval, in: 10...300, step: 10)
                .padding()
            
            Text("\(Int(interval)) seconds")
                .padding(.bottom)
            
            Button(isStarted ? "Stop Notifications" : "Start Notifications") {
                if isStarted {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                } else {
                    requestPermission()
                    scheduleNotification(interval: interval)
                }
                isStarted.toggle()
            }
            .padding()
            .background(isStarted ? Color.red : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear {
            requestPermission()
        }
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(interval: Double) {
        let content = UNMutableNotificationContent()
        content.title = "Look Up!"
        content.body = "Take a look at your child."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
