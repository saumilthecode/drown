import SwiftUI
import ActivityKit
import WidgetKit




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


