import SwiftUI

struct ScheduleView: View {
    @State private var selectedDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date() // Default end time is 1 hour after current time
    @EnvironmentObject private var themeManager: ThemeManager

    // Logic state variables
    @State private var showSkillsAlert = false
    @State private var showRecordsAlert = false
    @State private var showProgressAlert = false
    
    // Closure to pass the selected schedule back
    var onSchedule: ((Date, Date) -> Void)?

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

            // Start time
            VStack(alignment: .leading, spacing: 10) {
                Text("Starts")
                    .font(.headline)

                DatePicker(
                    "",
                    selection: $startTime,
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
            .onChange(of: startTime) {
                // Ensure startTime is before endTime
                if startTime >= endTime {
                    endTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime) ?? endTime
                }
            }

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
            .onChange(of: endTime) {
                // Ensure endTime is after startTime
                if endTime <= startTime {
                    endTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime) ?? endTime
                }
            }

            Spacer()

            // Buttons
            HStack {
                Button(action: {
                    // Skills button logic
                    showSkillsAlert.toggle()
                }) {
                    Text("Skills")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
                .alert(isPresented: $showSkillsAlert) {
                    Alert(title: Text("Skills"), message: Text("Skills functionality coming soon!"), dismissButton: .default(Text("OK")))
                }

                Button(action: {
                    // Records button logic
                    showRecordsAlert.toggle()
                }) {
                    Text("Records")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }
                .alert(isPresented: $showRecordsAlert) {
                    Alert(title: Text("Records"), message: Text("Records functionality coming soon!"), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)

            Button(action: {
                // Pass back the selected start and end times
                onSchedule?(startTime, endTime)
            }) {
                Text("Schedule Notifications")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .alert(isPresented: $showProgressAlert) {
                Alert(title: Text("Insights & Progress"), message: Text("Insights & Progress functionality coming soon!"), dismissButton: .default(Text("OK")))
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing
                                  )
        )
    }
}
