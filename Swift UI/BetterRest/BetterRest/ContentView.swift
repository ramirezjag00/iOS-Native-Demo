//
//  ContentView.swift
//  BetterRest
//
//  Created by Andrey Ramirez on 7/18/22.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var sleepTime: Date {
        var bedTime = Date.now

        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount) + Double(1))
            bedTime = wakeUp - prediction.actualSleep
        } catch {
            print(error)
        }
        
        return bedTime
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("When do you want to wake up?")) {
                    DatePicker(selection: $wakeUp, displayedComponents: .hourAndMinute) {
                        Text("Please enter a time")
                        .frame(alignment: .trailing)
                    }
                }

                Section (header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section (header: Text("Daily coffee intake")) {
                    Picker(coffeeAmount + 1 == 1 ? "Cup" : "Cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {cups in
                            Text("\(cups)")
                        }
                    }
                }
                
                Section (header: Text("Your ideal bedtime is")) {
                    Text(sleepTime.formatted(date: .omitted, time: .shortened))
                }
                .headerProminence(.increased)
            }
            .foregroundColor(.black)
            .navigationTitle("BetterRest")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
