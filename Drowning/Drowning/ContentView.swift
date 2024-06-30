import SwiftUI
import UserNotifications
import ActivityKit

struct ContentView: View {
    @State private var interval: Double = 10 // Default interval in seconds
    @State private var isStarted: Bool = false
    @State private var permissionGranted: Bool = false // Track permission status
    @State private var liveActivity: Activity<NotificationAttributes>? = nil
    @State private var progress: Double = 0 // Progress of the circular timer
    @State private var timer: Timer? = nil
    @State private var showSettingsSheet = false
    @State private var showScheduleSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ZStack {
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
                        .foregroundColor(self.progress > 0 ? .yellow : .clear) // Adjust fill color here
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
                                    scheduleNotifications(interval: interval)
                                } else {
                                    requestPermission {
                                        scheduleNotifications(interval: interval)
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
                Text("Settings View")
            }
            .sheet(isPresented: $showScheduleSheet) {
                Text("Schedule View")
            }
            .onAppear {
                requestPermission(completion: nil)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }

    func requestPermission(completion: (() -> Void)?) {
        // Your permission request code here
        permissionGranted = true // Simulated for example
        completion?()
    }

    func scheduleNotifications(interval: Double) {
        // Simulated notification scheduling
        let contentState = NotificationAttributes.ContentState(remainingTime: interval)
        startLiveActivity(interval: interval, contentState: contentState)
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
        // Your notification stopping code here
        liveActivity = nil
        print("All notifications stopped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
