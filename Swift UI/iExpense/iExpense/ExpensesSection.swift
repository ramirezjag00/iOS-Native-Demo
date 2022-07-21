//
//  ExpensesSection.swift
//  iExpense
//
//  Created by Andrey Ramirez on 7/21/22.
//

import Foundation
import SwiftUI

struct PriceStyle: ViewModifier {
    let price: Double

    func body(content: Content) -> some View {
        if price <= 10 {
            content
                .foregroundColor(.orange)
        } else if (price > 10 && price < 100) {
            content
                .foregroundColor(.red)
        } else if (price >= 100) {
            content
                .foregroundColor(.purple)
        }
    }
}

extension View {
    func styledPrice(price: Double) -> some View {
        self.modifier(PriceStyle(price: price))
    }
}

struct ExpensesSection: View {
    let sectionHeader: String
    let list: [ExpenseItem]
    @ObservedObject var expenses: Expenses

    var body: some View {
        Section (header: Text(sectionHeader)) {
            ForEach(list) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }

                    Spacer()
                    Text(item.amount, format: .currency(code: item.currency))
                        .styledPrice(price: item.amount)
                }
            }
            .onDelete(perform: { indexSet in
                let itemSubIndex = indexSet.filter({ $0 >= 0 })[0]
                if let itemMainIndex = expenses.items.firstIndex(where: { $0.id == list[itemSubIndex].id }) {
                    let newIndexSet = IndexSet([itemMainIndex])
                    removeItem(at: newIndexSet)
                }
            })
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ExpensesSection_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesSection(sectionHeader: "Foo", list: Expenses().items, expenses: Expenses())
    }
}

