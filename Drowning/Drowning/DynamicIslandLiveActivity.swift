import SwiftUI
import ActivityKit
import WidgetKit

struct NotificationAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var remainingTime: Double
    }
    
    var contentState: ContentState
    var interval: Int
    
    init(interval: Int, remainingTime: Double) {
        self.interval = interval
        self.contentState = ContentState(remainingTime: remainingTime)
    }
}




struct LockScreenView: View {
    let remainingTime: Double
    
    var body: some View {
        VStack {
            Text("Look Up!")
                .font(.headline)
            Text("Take a look at your child.")
                .font(.caption)
            Text("\(Int(remainingTime))s")
                .font(.subheadline)
        }
    }
}


