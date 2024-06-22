////
////  LiveActivityView.swift
////  Drowning
////
////  Created by Saumil Anand on 22/6/24.
////

import SwiftUI
import ActivityKit

struct LiveActivityView: View {
    let activity: Activity<NotificationAttributes>

    var body: some View {
        VStack {
            Text("Notification in progress")
             .font(.headline)
            Text("Interval: \(activity.attributes.interval) seconds")
            // You can't access the remaining time directly from the Activity
            // You need to use @DynamicIsland or ActivityView to access the state
        }
     .padding()
    }
}
