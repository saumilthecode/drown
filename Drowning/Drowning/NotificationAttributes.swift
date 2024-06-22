//
//  NotificationAttributes.swift
//  Drowning
//
//  Created by Saumil Anand on 22/6/24.
//

import ActivityKit

struct NotificationAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var interval: Double
        var remainingTime: Double
    }

    var interval: Double
}
