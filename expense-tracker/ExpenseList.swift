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
        // Create new expense and add to expense list
        let newExpense = Expense(amount: amount, category: category)
        expenses.append(newExpense)
    }
    
    static func load() {
            // Seed default expenses for demo purposes
            self.expenses = [
                Expense(amount: 10, category: "Food"),
            ]
    }

    
}

