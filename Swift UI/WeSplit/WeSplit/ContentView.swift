//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrey Ramirez on 7/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double?
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let currentCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        if let safeCheckAmount = checkAmount {
            let tipValue = safeCheckAmount / 100 * tipSelection
            let grandTotal = safeCheckAmount + tipValue
            return grandTotal
        }
        
        return 0.0
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currentCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section (header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section (header: Text("Total Amount")) {
                    Text(totalAmount, format: currentCurrency)
                }
                
                Section (header: Text("Amount per person")) {
                    Text(totalPerPerson, format: currentCurrency)
                }.headerProminence(.increased)
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
