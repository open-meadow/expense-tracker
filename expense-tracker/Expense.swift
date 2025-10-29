//
//  Expense.swift
//  expense-tracker
//
//  Created by open-meadow on 2025-10-28.
//

struct Expense: Equatable, Codable {
    let amount: Double
    let category: String
    
    init(amount: Double, category: String){
        self.amount = amount
        self.category = category
    }
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        return lhs.amount == rhs.amount && lhs.category == rhs.category
    }
}
