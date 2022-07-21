//
//  AddView.swift
//  iExpense
//
//  Created by Andrey Ramirez on 7/21/22.
//

import SwiftUI

enum CurrencyCode: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    case AUD, CAD, EUR, GBP, NZD, USD
}

struct CurrencyPicker: View {
    @Binding var selected: CurrencyCode
    let label = "Currency"
    var body: some View {
        Picker(label, selection: $selected) {
            ForEach(CurrencyCode.allCases) {
                Text($0.rawValue)
                    .tag($0)
            }
        }.pickerStyle(.segmented)
    }
}

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = CurrencyCode.USD
    @State private var shouldShake = false
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss

    let types = ["Business", "Personal"]
    
    var isValid: Bool {
        return name.count > 0 && amount > 0.0
    }
    
    var activeCurrency: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: currency.rawValue)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .offset(x: (shouldShake && name.isEmpty) ? 30 : 0)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)

                CurrencyPicker(selected: $currency)

                TextField("Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .offset(x: (shouldShake && amount == 0) ? 30 : 0)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    saveAndClose()
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
        
        let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency.rawValue)
        expenses.items.append(item)
        self.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
