import SwiftUI
import UserNotifications
import ActivityKit

struct ContentView: View {
    @State private var interval: Double = 30 // Default interval in seconds
    @State private var isStarted: Bool = false
    @State private var notificationCount: Int = 10 // Number of notifications to schedule in advance
    @State private var permissionGranted: Bool = false // Track permission status
    @State private var activities: [Activity<NotificationAttributes>] = []
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                if isStarted {
                    stopNotifications()
                } else {
                    if permissionGranted {
                        scheduleNotifications(interval: interval)
                    } else {
                        requestPermission {
                            scheduleNotifications(interval: interval)
                        }
                    }
                }
                isStarted.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(isStarted ? Color.red : Color(hex: "05A0BF"))
                        .frame(width: 150, height: 150)
                        .shadow(color: isStarted ? Color.red.opacity(0.5) : Color(hex: "05A0BF").opacity(0.5), radius: 10, x: 0, y: 0)
                    
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
            DispatchQueue.main.async {
                if granted {
                    print("Permission granted")
                    permissionGranted = true
                    completion?()
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    print("Permission denied")
                }
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
            
            // Start a live activity
            startLiveActivity(interval: interval, index: i + 1)
        }
    }
    
    func startLiveActivity(interval: Double, index: Int) {
        let attributes = NotificationAttributes(interval: Int(interval), remainingTime: interval * Double(index))
        let initialContentState = NotificationAttributes.ContentState(remainingTime: interval * Double(index))
        do {
            let activity = try Activity<NotificationAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil
            )
            activities.append(activity)
            print("Started live activity \(index)")
        } catch {
            print("Error starting live activity: \(error.localizedDescription)")
        }
    }
    
    func stopNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notifications stopped")
        
        // End all live activities
        for activity in activities {
            Task {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
        activities.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000ff) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
