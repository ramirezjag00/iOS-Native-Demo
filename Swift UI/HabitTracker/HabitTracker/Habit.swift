//
//  Habit.swift
//  HabitTracker
//
//  Created by Andrey Ramirez on 7/27/22.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let icon: String
    var completedDates: [Date?]
    let startDate: Date?
    let endDate: Date?
    let time: Date?
    let isDaily: Bool
    
    var formattedDailyTime: String {
        time?.formatted(date: .omitted, time: .shortened) ?? "N/A"
    }
}
