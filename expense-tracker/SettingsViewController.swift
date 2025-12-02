//
//  SettingsViewController.swift
//  expense-tracker
//
//  Created by open-meadow on 2025-11-30.
//
import UIKit

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let symbols = ["$", "€", "£", "₹"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExpenseList.unarchive()
        
        let current = loadCurrency()
        if let index = symbols.firstIndex(of: current) {
            segmentedControl.selectedSegmentIndex = index
        } else {
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func exportCSV() {
        var csv = "amount,category,date\n"
        for expense in ExpenseList.expenses {
            csv += "\(expense.amount),\(expense.category),\(expense.date)\n"
        }
        
        let filename = getDocumentsDirectory().appendingPathComponent("expenses.csv")
        do {
            try csv.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            print("CSV may have been created: ", filename)
            
            let shareSheet = UIActivityViewController(activityItems: [filename], applicationActivities: nil)
            present(shareSheet, animated: true, completion: nil)
        } catch {
            print("Cannot create CSV file: ", error)
        }
        
    }
    
    func exportJSON() {
        let url = getDocumentsDirectory().appendingPathComponent("expenses.json")
        
        do {
            let data = try JSONEncoder().encode(ExpenseList.expenses)
            try data.write(to: url)
            print("JSON exported to:", url)
            
            let shareSheet = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            present(shareSheet, animated: true)
            
        } catch {
            print("Failed to create JSON file:", error)
        }
    }
    
    @IBAction func exportCSVButton(_ sender: UIButton) {
        exportCSV()
    }
    
    @IBAction func exportJSONButton(_ sender: UIButton) {
        exportJSON()
    }
    
    func saveCurrency(_ symbol: String) {
        UserDefaults.standard.set(symbol, forKey: "currencySymbol")
    }
    
    func loadCurrency() -> String {
        return UserDefaults.standard.string(forKey: "currencySymbol") ?? "$"
    }
    
    @IBAction func selectCurrency(_ sender: UISegmentedControl) {
        let chosen = symbols[sender.selectedSegmentIndex]
        saveCurrency(chosen)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
            let chosen = symbols[segmentedControl.selectedSegmentIndex]
            UserDefaults.standard.set(chosen, forKey: "currencySymbol")
            self.dismiss(animated: true, completion: nil)
        }
}
