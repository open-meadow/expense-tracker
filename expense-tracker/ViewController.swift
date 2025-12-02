import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var expensesTitleLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view has loaded")
        ExpenseList.unarchive()
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        updateExpensesDisplay(page: 0)
    }
    
    @IBAction func expensesDisplayControl(_ sender: UIPageControl) {
        updateExpensesDisplay(page: sender.currentPage)
    }
    
    // Get expenses for current day (if year, day and month of expense is the same as year, day and month of today)
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
    
    // Get expenses for current month (if year and month of expense is the same as year and month of today)
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
    
    // Get expenses for current year (if year of expense is the same as year of today, )
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
    
    // Get sum of all expenses from expensesDisplay and show to expensesLabel
    func updateExpensesDisplay(page:Int) {
        var expensesDisplay: [Expense] = []
        
        switch page {
        case 0:
            expensesDisplay = expensesDay()
            expensesTitleLabel.text = "Today's Expenses"
        case 1:
            expensesDisplay = expensesMonth()
            expensesTitleLabel.text = "This Month's Expenses"
        case 2:
            expensesDisplay = expensesYear()
            expensesTitleLabel.text = "This Year's Expenses"
        default:
            break
        }
        
        var total: Double = 0
        for expense in expensesDisplay {
            total += expense.amount
        }
        let currency = UserDefaults.standard.string(forKey: "currencySymbol")
        expensesLabel.text = "\(currency ?? "$")\(total)"
    }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        updateExpensesDisplay(page: 0)
    }
    
    // dismiss method of ViewController
    // create a delegate for the segment controller, delegate functions run every time the segment is changed
}

