import SwiftUI
import ActivityKit

struct LiveActivityView: View {
    let activity: Activity<NotificationAttributes>
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Look Up!")
                    .font(.headline)
                Text("Interval: \(activity.attributes.interval) seconds")
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
    }
}
