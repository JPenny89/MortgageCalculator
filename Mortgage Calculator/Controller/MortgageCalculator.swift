//
//  ViewController.swift
//  Mortgage Calculator
//
//  Created by James Penny on 19/12/2022.
//

import UIKit
import Foundation

class MortgageCalculator: UIViewController {
    
    var parameters = Parameters(rate: 0.0, loan: 0.0, term: 0.0)
    
    
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var loanTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    @IBOutlet weak var monthlyPayment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        let rate = Double (interestTextField.text!) ?? 0.0
        let loan = Double (loanTextField.text!) ?? 0.0
        let term = Double (termTextField.text!) ?? 0.0
        
        let interestRate = (rate/100)/12
        let totalPayments = term * 12
        let firstNumber = 1 + interestRate
        let firstPower = pow(firstNumber, totalPayments)
        let topLine = interestRate * firstPower
        
        let bottomLine = firstPower - 1
        
        let bothLines = topLine / bottomLine
        
        
        let monthlyPaymentFigure = loan * bothLines
        
        
        
        
        monthlyPayment.text = "£" + String(format: "%.2f", Double(monthlyPaymentFigure))
        
        print("Interest Rate Decimal = \(interestRate)")
        print("Loan Amount = \(loan)")
        print("Total Term Payments = \(totalPayments)")
        print("Top Line = \(topLine)")
        print("Bottom Line = \(bottomLine)")
        print("Both Lines = \(bothLines)")
        
    }
    

}

