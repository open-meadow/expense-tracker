//
//  Expense.swift
//  expense-tracker
//
//  Created by open-meadow on 2025-10-28.
//

import UIKit

struct Expense: Equatable, Codable {
    let amount: Double
    let category: String
    let date: Date
    
    init(amount: Double, category: String){
        self.amount = amount
        self.category = category
        self.date = Date()
    }
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        return lhs.amount == rhs.amount
        && lhs.category == rhs.category
        && lhs.date == rhs.date
    }
}
