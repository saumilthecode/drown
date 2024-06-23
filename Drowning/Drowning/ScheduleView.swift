import SwiftUI


struct ScheduleView: View {
    @State private var selectedDate = Date()
    @State private var endTime = Date()

    var body: some View {
        VStack {
            // Month and calendar view
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 20)

            // End time
            VStack(alignment: .leading, spacing: 10) {
                Text("Ends")
                    .font(.headline)

                DatePicker(
                    "",
                    selection: $endTime,
                    displayedComponents: [.hourAndMinute]
                )
                .labelsHidden()
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color(.systemGray5))
                .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()

            // Buttons
            HStack {
                Button(action: {}) {
                    Text("Skills")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }

                Button(action: {}) {
                    Text("Records")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

            Button(action: {}) {
                Text("Insights & Progress")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
