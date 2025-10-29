import UIKit

class AddExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    let categories = [
        "Food",
        "Transport",
        "Groceries",
        "Entertainment",
        "Clothing",
        "Health",
        "Bills",
        "Miscellaneous"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        selectedCategory = categories[0]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    var selectedCategory: String?
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        let amountText = amountTextField.text ?? "0"
        let amount = Double(amountText) ?? 0
        let category = selectedCategory ?? categories[-1]
        
        ExpenseList.addExpense(amount: amount, category: category)
        ExpenseList.archive()
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
}
