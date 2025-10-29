//
//  ViewController.swift
//  expense-tracker
//
//  Created by open-meadow on 2025-10-27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ExpenseList.unarchive()
        updateTotalLabel()
    }
    
    @IBOutlet weak var totalLabel: UILabel!
    
    func updateTotalLabel() {
        var total: Double = 0
        for expense in ExpenseList.expenses {
            total += expense.amount
        }
        totalLabel.text = "$\(total)"
    }

}

