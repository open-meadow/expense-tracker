import UIKit

class CategoryExpenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var categoryTable: UITableView!
    var categorySumDict: [String: Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
        _ = ExpenseList()
        ExpenseList.unarchive()
        
        if ExpenseList.expenses == nil {
            ExpenseList.expenses = []
        }
        calculateTotals()
    }
    
    func calculateTotals() {
        // uses dictionary to save amount for each category
        categorySumDict = [:]
        
        for expense in ExpenseList.expenses {
            categorySumDict[expense.category] = 0
        }
        
        for expense in ExpenseList.expenses {
            categorySumDict[expense.category]! += expense.amount
        }
        
        categoryTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorySumDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)
        let category = Array(categorySumDict.keys)[indexPath.row]
        let total = categorySumDict[category] ?? 0.0
        
        cell.textLabel?.text = category
        cell.detailTextLabel?.text = "$\(String(format: "%.2f", total))"
        return cell
    }
}
