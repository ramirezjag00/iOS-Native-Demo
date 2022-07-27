//
//  ContentView.swift
//  HabitTracker
//
//  Created by Andrey Ramirez on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddHabit = false
    @State private var animationAmount = 0.0
    @State private var selectedDate = Date()
    @State private var filteredHabits: [Habit] = []
    @StateObject var habits = Habits()
    
    var percentageCompleted: Double {
        guard filteredHabits.count > 0 else { return  Double(0) }
        let completedHabits = Double(filteredHabits.filter({ isCompleted($0.completedDates) }).count)
        let totalHabits = Double(filteredHabits.count)
        return completedHabits / totalHabits * 100.0
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {

                //MARK: - Dates
                Text(getSelectedDayMonthYear())
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 18) {
                        ForEach(0..<30) {multiplier in
                            Button {
                                withAnimation(.easeInOut){
                                    selectedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now.addingTimeInterval(86400 * Double(multiplier)))!
                                }
                            } label: {
                                Group {
                                    if isSelected(multiplier) {
                                        VStack {
                                            Text(getTodayWeekDay(multiplier))
                                            Text(getDay(multiplier))
                                        }
                                        .padding()
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 68, height: 80)
                                        .background(LinearGradient(colors: [Color.pink.opacity(0.3), Color.red.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        VStack {
                                            Text(getTodayWeekDay(multiplier))
                                                .font(.headline)
                                                .foregroundColor(.gray.opacity(0.5))
                                            Text(getDay(multiplier))
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                        .frame(width: 68, height: 80)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.black.opacity(0.1), lineWidth: 1)
                                        )
                                    }
                                }
                            }
                        }
                    }
                }

                //MARK: - Hero
                HStack {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 100, height: 100)
                            .blur(radius: 30)
                        Text("😌")
                            .font(.system(size: 100))
                    }
                    
                    Spacer()
                        
                    VStack(alignment: .leading) {
                        Text("Your Daily Goal Progress")
                            .font(.system(size: 13, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        ProgressView(value: percentageCompleted, total: 100.0)
                            .tint(.white)
                            .frame(width: 200)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                        HStack {
                            Spacer()
                            Text("\(String(format: "%.2f", percentageCompleted))%")
                                .font(.system(size: 10, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                    .fixedSize()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .background(LinearGradient(colors: [Color.pink.opacity(0.3), Color.red.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.vertical)
                
                //MARK: - Habits
                
                Text("\(titleDatePrefix()) Habits")
                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

                Group {
                    if filteredHabits.isEmpty {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(.red.opacity(0.4))
                                    .frame(width: 30, height: 30)
                                Image(systemName: "questionmark")
                                    .foregroundColor(.white)
                            }
                            VStack(alignment: .leading) {
                                Text("No plans yet")
                                    .font(.system(size: 13, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                Text("Create a habit")
                                    .font(.system(size: 13, design: .rounded))
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: -5)
                        .shadow(color: Color.gray.opacity(0.1), radius: 8, x: 0, y: 5)
                    } else {
                        VStack(spacing: 20) {
                            ForEach(filteredHabits) { habit in
                                Button {
                                    var filteredHabit = habits.items.filter({ $0.id == habit.id })[0]
                                    let habitIndex = habits.items.firstIndex(of: habit)!

                                    if filteredHabit.completedDates.contains(selectedDate) {
                                        let dateIndex = filteredHabit.completedDates.firstIndex(of: selectedDate)!
                                        filteredHabit.completedDates.remove(at: dateIndex)
                                    } else {
                                        filteredHabit.completedDates.append(selectedDate)
                                    }
                                    
                                    withAnimation {
                                        habits.items[habitIndex] = filteredHabit
                                        loadItems()
                                    }
                                } label: {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .fill(.red.opacity(0.4))
                                                .frame(width: 30, height: 30)
                                            Image(systemName: habit.icon)
                                                .foregroundColor(.white)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(habit.title)
                                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                                .foregroundColor(.black)
                                            Text(isCompleted(habit.completedDates) ? "Completed" : "In-progress")
                                                .font(.system(size: 13, design: .rounded))
                                                .foregroundColor(.black)
                                            Text(habit.formattedDailyTime)
                                                .font(.system(size: 10, design: .rounded))
                                                .foregroundColor(.black.opacity(0.5))
                                        }
                                        
                                        Spacer()
                                        
                                        Group {
                                            if isCompleted(habit.completedDates) {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.red.opacity(0.7))
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: -5)
                                    .shadow(color: Color.gray.opacity(0.1), radius: 8, x: 0, y: 5)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: self.$showingAddHabit) {
                AddView(habits: habits)
            }
            .preferredColorScheme(.light)
            .onAppear {
                selectedDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now)!
                loadItems()
            }
            .onChange(of: selectedDate, perform: { _ in
                loadItems()
            })
            .onChange(of: showingAddHabit, perform: { _ in
                loadItems()
            })
            //MARK: - ToolBar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Circle()
                            .fill(.red.opacity(0.4))
                            .frame(width: 30, height: 30)
                        VStack (alignment: .leading) {
                            Text("Hello,")
                                .font(.headline)
                            Text("Bilbo Baggins")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddHabit.toggle()
                    } label: {
                        Image(systemName: "doc.badge.plus")
                            .foregroundColor(.red.opacity(0.6))
                            .padding()
                    }
                    .padding(5)
                    .background(.clear)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.red)
                            .scaleEffect(animationAmount)
                            .opacity(1 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    )
                    .onAppear {
                        animationAmount = 1
                    }

                }
            }
        }
        
    }
    
    func getTodayWeekDay(_ multiplier: Int) -> String {
        let date = Date.now.addingTimeInterval(86400 * Double(multiplier))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
    
    func getSelectedDayMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM yyyy"
        let dayMonthYear = dateFormatter.string(from: selectedDate)
        return dayMonthYear
    }
    
    func getDay(_ multiplier: Int) -> String {
        let date = Date.now.addingTimeInterval(86400 * Double(multiplier))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)
        return day
    }
    
    func isSelected(_ multiplier: Int) -> Bool {
        let date = Date.now.addingTimeInterval(86400 * Double(multiplier))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        let formattedDate = dateFormatter.string(from: date)
        let formattedSelectedDate = dateFormatter.string(from: selectedDate)
        return formattedDate == formattedSelectedDate
    }
    
    func titleDatePrefix() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"

        let formattedDate = dateFormatter.string(from: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now)!)
        let formattedTomorrowDate = dateFormatter.string(from: calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date.now.addingTimeInterval(86400))!)
        let formattedSelectedDate = dateFormatter.string(from: selectedDate)
        
        if formattedSelectedDate == formattedDate {
            return "Today"
        } else if formattedSelectedDate == formattedTomorrowDate {
            return "Tomorrorow"
        } else {
            dateFormatter.dateFormat = "MMMM"
            return "\(dateFormatter.string(from: selectedDate)) \(toOrdinalDay(selectedDate))"
        }
    }
    
    func toOrdinalDay(_ date: Date) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let dateComponents = Calendar.current.component(.day, from: date)
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        return day!
    }
    
    func isCompleted(_ dates: [Date?]) -> Bool {
        guard !dates.isEmpty else { return false }
        return dates.contains(selectedDate)
    }
    
    func loadItems() {
        guard habits.items.count > 0 else { filteredHabits = []; return }
        filteredHabits = habits.items.filter { $0.isDaily ||  (!$0.isDaily && selectedDate >= $0.startDate! && selectedDate <= $0.endDate!) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
