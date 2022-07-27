//
//  AddView.swift
//  HabitTracker
//
//  Created by Andrey Ramirez on 7/26/22.
//

import SwiftUI

struct AddView: View {
    @State private var title = ""
    @State private var icon = "zzz"
    @State private var isDaily = false
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State private var dailyTime = defaultDailyTime
    @State private var shouldShake = false
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss

    var isValid: Bool {
        return isDaily ? !title.isEmpty : !title.isEmpty && startDate <= endDate
    }
    
    static var defaultDailyTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    let activities = ["zzz", "laptopcomputer.and.iphone", "drop.fill", "fork.knife", "cup.and.saucer.fill", "leaf.fill", "person.fill.questionmark"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit Title") ) {
                    TextField("Enter habit name", text: $title)
                        .offset(x: (shouldShake && title.isEmpty) ? 30 : 0)
                        .accentColor(.red.opacity(0.5))
                }
                Section(header: Text("Choose Activity Icon") ) {
                    Picker("Choose Activity", selection: $icon) {
                        ForEach(activities, id: \.self) {
                            Image(systemName: $0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(.red.opacity(0.5))
                }
                
                Section (header: Text("Choose a datetime")) {
                    Toggle(isDaily ? "Daily" : "Date Range", isOn: $isDaily)
                        .toggleStyle(SwitchToggleStyle(tint: .red.opacity(0.5)))
                    Group {
                        if isDaily {
                            DatePicker(selection: $dailyTime, displayedComponents: .hourAndMinute) {
                                Text("Trigger Time")
                                .frame(alignment: .trailing)
                            }
                            .colorMultiply(.red)
                        } else {
                            DatePicker(selection: $startDate, in: Date.now..., displayedComponents: .date) {
                                Text("Start")
                                .frame(alignment: .trailing)
                            }
                            .colorMultiply(.red)
                            DatePicker(selection: $endDate, in: Date.now..., displayedComponents: .date) {
                                Text("End")
                                .frame(alignment: .trailing)
                            }
                            .colorMultiply(.red)
                            DatePicker(selection: $dailyTime, displayedComponents: .hourAndMinute) {
                                Text("Trigger Time")
                                .frame(alignment: .trailing)
                            }
                            .colorMultiply(.red)
                        }
                    }
                }
                .offset(x: (shouldShake && (isDaily ? false : startDate > endDate)) ? 30 : 0)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        
                        Button(action: {
                            self.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(.black)
                        })
                        Text("Add Habit")
                            .font(.system(size: 16, weight: .black, design: .rounded))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveAndClose()
                    }, label: {
                        Text("Save")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.red.opacity(0.6))
                    })
                }

            }
        }
    }
    
    func saveAndClose() {
        guard isValid else {
            shouldShake.toggle()
            withAnimation(Animation.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                shouldShake.toggle()
            }
            return
        }
        
        let item = Habit(title: title, icon: icon, completedDates: [], startDate: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate)!, endDate: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: endDate)!, time: dailyTime, isDaily: isDaily)
        habits.items.append(item)

        self.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
