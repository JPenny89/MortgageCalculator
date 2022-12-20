//
//  ViewController.swift
//  Mortgage Calculator
//
//  Created by James Penny on 19/12/2022.
//

import UIKit
import Foundation

class MortgageCalculator: UIViewController {
    
//    var parameters = Parameters(rate: 0.0, loan: 0.0, term: 0.0)
    

    
    
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var loanTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var stampDuty: UILabel!
    @IBOutlet weak var loanToValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func calculateMonthlyRepayment() {
        
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

    
    func calculateStampDuty() {
        
        let propertyValue = Double (valueTextField.text!) ?? 0.0
        
        if propertyValue > 1500000 {
            let bandFourTop = propertyValue - 1500000
            let bandFourPercentage = (bandFourTop * 12) / 100
            let bandFourTotal = 33750 + 57500 + bandFourPercentage
            stampDuty.text = "£" + String(format: "%.2f", Double(bandFourTotal))
        } else if propertyValue > 925000 && propertyValue <= 1500000 {
            let bandThreeTop = propertyValue - 925000
            let bandThreePercentage = (bandThreeTop * 10) / 100
            let bandThreeTotal = 33750 + bandThreePercentage
            stampDuty.text = "£" + String(format: "%.2f", Double(bandThreeTotal))
        } else if propertyValue > 250000 && propertyValue <= 925000 {
            let bandTwoTop = propertyValue - 250000
            let bandTwoPercentage = (bandTwoTop * 5) / 100
            stampDuty.text = "£" + String(format: "%.2f", Double(bandTwoPercentage))
        } else {
            stampDuty.text = "£" + String(format: "%.2f", 0)
        }
        
    }
    
    func calculateLTV() {
        
        let loan = Double (loanTextField.text!) ?? 0.0
        let value = Double (valueTextField.text!) ?? 0.0
        
        let ltv = (loan/value) * 100
        
        loanToValue.text = String(format: "%.1f", Double(ltv)) + "%"
        
    }
        

    @IBAction func calculatePressed(_ sender: Any) {
        
        calculateMonthlyRepayment()
        calculateStampDuty()
        calculateLTV()
        
    }

}

