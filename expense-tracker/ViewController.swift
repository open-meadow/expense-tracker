import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ExpenseList.unarchive()
        updateExpensesDisplay(page: 0)
    }
    
    @IBOutlet weak var expensesLabel: UILabel!
    
    @IBAction func expensesDisplayControl(_ sender: UIPageControl) {
        updateExpensesDisplay(page: sender.currentPage)
    }
    
    func expensesDay() -> [Expense] {
        let today = Date()
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: today)
        
        var result = [Expense]()
        for expense in ExpenseList.expenses {
            let expenseDate = Calendar.current.dateComponents([.year, .month, .day], from: expense.date)
            if expenseDate.year == todayComponents.year &&
                expenseDate.month == todayComponents.month &&
                expenseDate.day == todayComponents.day {
                result.append(expense)
            }
        }
        
        return result
    }
    
    func expensesMonth() -> [Expense] {
        let today = Date()
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: today)
        
        var result = [Expense]()
        for expense in ExpenseList.expenses {
            let expenseDate = Calendar.current.dateComponents([.year, .month, .day], from: expense.date)
            if expenseDate.year == todayComponents.year &&
                expenseDate.month == todayComponents.month {
                result.append(expense)
            }
        }
        
        return result
    }
    
    func expensesYear() -> [Expense] {
        let today = Date()
        let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: today)
        
        var result = [Expense]()
        for expense in ExpenseList.expenses {
            let expenseDate = Calendar.current.dateComponents([.year, .month, .day], from: expense.date)
            if expenseDate.year == todayComponents.year {
                result.append(expense)
            }
        }
        
        return result
    }
    
    func updateExpensesDisplay(page:Int) {
        var expensesDisplay: [Expense] = []
        
        switch page {
        case 0:
            expensesDisplay = expensesDay()
        case 1:
            expensesDisplay = expensesMonth()
        case 2:
            expensesDisplay = expensesYear()
        default:
            break
        }
        
        var total: Double = 0
        for expense in expensesDisplay {
            total += expense.amount
        }
        
        expensesLabel.text = "$\(total)"
    }

}

