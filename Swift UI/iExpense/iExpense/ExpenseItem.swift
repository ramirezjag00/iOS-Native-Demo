//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Andrey Ramirez on 7/21/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}
