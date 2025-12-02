import UIKit

class AddExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var categories: [String] = [String]()
    
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        
        categories = [
            "Food",
            "Transport",
            "Groceries",
            "Entertainment",
            "Clothing",
            "Health",
            "Bills",
            "Miscellaneous"
        ]
        selectedCategory = categories[0]
        
        let color = UserDefaults.standard.string(forKey: "backgroundColor") ?? "#365EB5"
        view.backgroundColor = UIColor(hex: color)
    }
    
    // next five functions required for picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = categories[row]
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }

    
    // create new expense and add to expense list
    @IBAction func saveButton(_ sender: UIButton) {
        let amountText = amountTextField.text ?? "0"
        let amount = Double(amountText) ?? 0
        let category = selectedCategory ?? categories[-1]
        
        let expense = Expense(amount: amount, category: category)
        ExpenseList.expenses.append(expense)
        ExpenseList.archive()
        
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
}
