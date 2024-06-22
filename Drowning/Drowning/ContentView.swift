import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var interval: Double = 30 // Default interval in seconds
    @State private var isStarted: Bool = false
    @State private var notificationCount: Int = 10 // Number of notifications to schedule in advance
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                if isStarted {
                    stopNotifications()
                } else {
                    requestPermission {
                        scheduleNotifications(interval: interval)
                    }
                }
                isStarted.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(isStarted ? Color.red : Color.green)
                        .frame(width: 150, height: 150)
                        .shadow(color: isStarted ? Color.red.opacity(0.5) : Color.green.opacity(0.5), radius: 10, x: 0, y: 0)
                    
                    Image(systemName: "power")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                }
            }
            
            Spacer()
            
            Text("Set Interval (seconds)")
                .font(.headline)
                .padding(.bottom, 10)
            
            Slider(value: $interval, in: 10...300, step: 10)
                .padding(.horizontal, 40)
            
            Text("\(Int(interval)) seconds")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 40)
            
        }
        .onAppear {
            requestPermission(completion: nil)
        }
    }
    
    func requestPermission(completion: (() -> Void)?) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
                completion?()
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotifications(interval: Double) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // Clear existing notifications
        for i in 0..<notificationCount {
            let content = UNMutableNotificationContent()
            content.title = "Look Up!"
            content.body = "Take a look at your child."
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval * Double(i + 1), repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            print("Scheduling notification \(i + 1) at interval \(interval * Double(i + 1)) seconds")
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func stopNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notifications stopped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
