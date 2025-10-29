//
//  ExpenseList.swift
//  expense-tracker
//
//  Created by open-meadow on 2025-10-28.
//
import UIKit

class ExpenseList: Codable {
    static var expenses: [Expense]!

    static func unarchive() {
        do {
            if let file = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ExpenseList") {
                
                expenses = try JSONDecoder().decode([Expense].self, from: Data(contentsOf: file))
            }
            
        } catch {
            expenses = [Expense]()
        }
    }
    
    static func archive() {
        if let file = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ExpenseList") {
            try? JSONEncoder().encode(expenses).write(to: file)
        }
    }
    
    static func addExpense(amount: Double, category: String) {
        let newExpense = Expense(amount: amount, category: category)
        expenses.append(newExpense)
    }
    
    static func load() {
            // Seed default fruits for demo purposes
            self.expenses = [
                Expense(amount: 10, category: "Food"),
            ]
    }

    
}

