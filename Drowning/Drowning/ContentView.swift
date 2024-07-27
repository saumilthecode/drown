import SwiftUI
import UserNotifications
import ActivityKit
import TipKit



struct ContentView: View {
    @State private var interval: Double = 10 // Default interval in seconds
    @State private var timeSwimming: Double = 60 // Default time swimming in seconds
    @State private var isStarted: Bool = false
    @State private var permissionGranted: Bool = false // Track permission status
    @State private var liveActivity: Activity<NotificationAttributes>? = nil
    @State private var progress: Double = 0 // Progress of the circular timer
    @State private var timer: Timer? = nil
    @State private var showSettingsSheet = false
    @State private var showScheduleSheet = false
    @State private var showOnboardingSheet = false
    @State private var startTime: Date? = nil // Start time of the interval
    @State private var endTime: Date? = nil // End time of the interval
    @State private var notificationCount: Int = 0 // Track number of notifications
    @EnvironmentObject private var themeManager: ThemeManager
    var favoriteLandmarkTip = FavoriteLandmarkTip()

    var body: some View {
        NavigationView {

            VStack {
                Spacer()

                ZStack {
                    TipView(favoriteLandmarkTip, arrowEdge: .bottom)

                    Circle()
                        .fill(isStarted ? Color.red.opacity(0.3) : Color.green.opacity(0.3))
                        .frame(width: 200, height: 200)

                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.yellow)
                        .frame(width: 200, height: 200)

                    Circle()
                        .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(self.progress > 0 ? .yellow : .clear)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.linear, value: progress)
                        .frame(width: 200, height: 200)

                    Text(isStarted ? "Stop" : "Start")
                        .font(.title)
                        .foregroundColor(.black)
                        .onTapGesture {
                            if isStarted {
                                stopNotifications()
                            } else {
                                if permissionGranted {
                                    startTime = Date()
                                    endTime = startTime!.addingTimeInterval(timeSwimming)
                                    scheduleNotifications(start: startTime!, end: endTime!)
                                } else {
                                    requestPermission {
                                        startTime = Date()
                                        endTime = startTime!.addingTimeInterval(timeSwimming)
                                        scheduleNotifications(start: startTime!, end: endTime!)
                                    }
                                }
                            }
                            isStarted.toggle()
                        }
                }

                Spacer()

                Text("Set Interval (seconds)")
                    .font(.headline)
                    .padding(.bottom, 10)

                Slider(value: $interval, in: 2...100, step: 1)
                    .padding(.horizontal, 40)

                Text("\(Int(interval)) seconds")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                Text("Set Time Swimming (seconds)")
                    .font(.headline)
                    .padding(.bottom, 10)

                Slider(value: $timeSwimming, in: 10...600, step: 10)
                    .padding(.horizontal, 40)

                Text("\(Int(timeSwimming)) seconds")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                if isStarted, let start = startTime, let end = endTime {
                    Text("Notifications scheduled from \(start.formatted()) to \(end.formatted())")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }

                Spacer()

                if let liveActivity = liveActivity {
                    LiveActivityView(activity: liveActivity)
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    showSettingsSheet = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                },
                trailing: Button(action: {
                    showScheduleSheet = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                }
            )
            .sheet(isPresented: $showSettingsSheet) {
                SettingsView()
            }
            .sheet(isPresented: $showScheduleSheet) {
                ScheduleView { start, end in
                    self.startTime = start
                    self.endTime = end
                    showScheduleSheet = false
                }
            }
            .sheet(isPresented: $showOnboardingSheet) {
                OnboardingView()
            }
            .onAppear {
                requestPermission(completion: nil)
                checkFirstLaunch()
            }
            .background(LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing
                                      )
            )
            
            .task {
                // Configure and load your tips at app launch.
                do {
                    try Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                catch {
                    // Handle TipKit errors
                    print("Error initializing TipKit \(error.localizedDescription)")
                }
            }

        }
    }

    func requestPermission(completion: (() -> Void)?) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                permissionGranted = granted
                completion?()
            }
        }
    }

    func scheduleNotifications(start: Date, end: Date) {
        notificationCount = 0

        // Calculate total time and intervals
        let totalTime = end.timeIntervalSince(start)
        let intervalCount = Int(totalTime / interval)

        let contentState = NotificationAttributes.ContentState(remainingTime: interval)
        startLiveActivity(interval: interval, contentState: contentState)

        for i in 0..<intervalCount {
            let triggerDate = Calendar.current.date(byAdding: .second, value: Int(interval * Double(i)), to: start)!
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate), repeats: false)

            let content = UNMutableNotificationContent()
            content.title = "Look up"
            content.body = "Look at your child"
            content.sound = UNNotificationSound.default

            let request = UNNotificationRequest(identifier: "Notification_\(i)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification \(i): \(error.localizedDescription)")
                } else {
                    print("Notification \(i) scheduled at \(triggerDate)")
                }
            }
        }

        // Start the timer
        self.startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            updateProgress()
        }
    }

    func startLiveActivity(interval: Double, contentState: NotificationAttributes.ContentState) {
        let attributes = NotificationAttributes(interval: Int(interval), contentState: contentState)

        let staleDate = Date().addingTimeInterval(4 * 60 * 60) // 4 hours in seconds

        do {
            let activity = try Activity<NotificationAttributes>.request(
                attributes: attributes,
                content: ActivityContent(state: contentState, staleDate: staleDate),
                pushType: nil
            )
            liveActivity = activity
            print("Started live activity with interval \(interval)")

        } catch {
            print("Error starting live activity: \(error.localizedDescription)")
        }
    }

    func stopNotifications() {
        // Stop all scheduled notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        liveActivity = nil
        timer?.invalidate()
        timer = nil
        progress = 0
        startTime = nil
        notificationCount = 0
        print("All notifications stopped")
    }

    func updateProgress() {
        guard let startTime = startTime else { return }
        let elapsedTime = Date().timeIntervalSince(startTime)
        progress = (elapsedTime.truncatingRemainder(dividingBy: interval)) / interval

        if progress >= 1.0 {
            notificationCount += 1
            if notificationCount >= Int(timeSwimming / interval) {
                stopNotifications()
                progress = 0
                return
            }
            self.startTime = Date() // Reset the start time for the next interval
        }
    }

    func checkFirstLaunch() {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if !isFirstLaunch {
            showOnboardingSheet = true
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeManager())
    }
}

// LiveActivityView

struct NotificationAttributes: ActivityAttributes {
    var interval: Int
    var contentState: ContentState

    struct ContentState: Codable, Hashable {
        var remainingTime: Double
    }

    // Implement initializer required by ActivityAttributes
    init(interval: Int, contentState: ContentState) {
        self.interval = interval
        self.contentState = contentState
    }
}



struct FavoriteLandmarkTip: Tip {
    var title: Text {
        Text("Save as a Favorite")
    }


    var message: Text? {
        Text("Your favorite landmarks always appear at the top of the list.")
    }


    var image: Image? {
        Image(systemName: "star")
    }
}
