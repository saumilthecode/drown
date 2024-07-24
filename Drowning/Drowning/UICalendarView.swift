//
//  UICalendarView.swift
//  Drowning
//
//  Created by Saumil Anand on 24/7/24.
//

import SwiftUI
import UIKit

struct CalendarView: UIViewRepresentable {
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        return calendarView
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        // Ensure the calendar view fits its parent view
        if uiView.constraints.isEmpty {
            uiView.heightAnchor.constraint(equalToConstant: 400).isActive = true // Adjust height as needed
        }
    }

    static func dismantleUIView(_ uiView: UICalendarView, coordinator: ()) {
        // Clean up the view if needed
    }
}
