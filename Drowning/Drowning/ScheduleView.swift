import SwiftUI

struct ScheduleView: View {
    @State private var selectedDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    @EnvironmentObject private var themeManager: ThemeManager

    @State private var showSkillsAlert = false
    @State private var showRecordsAlert = false
    @State private var showProgressAlert = false

    var onSchedule: ((Date, Date) -> Void)?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [themeManager.selectedTheme.secondaryColor.opacity(0.5), Color.white]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea() // Apply ignoresSafeArea to the gradient

            ScrollView {
                Spacer()
                VStack(spacing: 30) { // Add spacing to create breathing room
                    // Month and calendar view
                    VStack {
                        Text("Select a Date")
                            .font(.headline)
                            .padding(.bottom, 5 )
                            .padding(.top, 10 )

                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 5)
                        )
                    }
                    .padding(.horizontal, 20)

                    // Start time
//                    VStack(alignment: .leading, spacing: 10) {
                
                    HStack{
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
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 3)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .onChange(of: startTime) {
                        if startTime >= endTime {
                            endTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime) ?? endTime
                        }
                    }

                    // End time
//                    VStack(alignment: .leading, spacing: 10) {
                    HStack{
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
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 3)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .onChange(of: endTime) {
                        if endTime <= startTime {
                            endTime = Calendar.current.date(byAdding: .minute, value: 30, to: startTime) ?? endTime
                        }
                    }

                    Spacer()


                    Button(action: {
                        onSchedule?(startTime, endTime)
                    }) {
                        Text("Schedule Notifications")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    .alert(isPresented: $showProgressAlert) {
                        Alert(title: Text("Insights & Progress"), message: Text("Insights & Progress functionality coming soon!"), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
    }
}


struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(ThemeManager())
    }
}
