//
//  ContentView.swift
//  iExpense
//
//  Created by Andrey Ramirez on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var businessExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Business" }
    }
    
    var personalExpenses: [ExpenseItem] {
        return expenses.items.filter { $0.type == "Personal" }
    }
    
    var body: some View {
        NavigationView {
            List {
                ExpensesSection(sectionHeader: "Business", list: businessExpenses, expenses: expenses)
                ExpensesSection(sectionHeader: "Personal", list: personalExpenses, expenses: expenses)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
            }
        }
        .sheet(isPresented: self.$showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
