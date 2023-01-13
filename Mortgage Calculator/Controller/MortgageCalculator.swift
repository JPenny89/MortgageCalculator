//
//  ViewController.swift
//  Mortgage Calculator
//
//  Created by James Penny on 19/12/2022.
//

import UIKit
import Foundation

class CellClass: UITableViewCell {
    
    
}

class MortgageCalculator: UIViewController {
    
//    var parameters = Parameters(rate: 0.0, loan: 0.0, term: 0.0)
    

    
    
    @IBOutlet weak var borrowingDropdown: UIButton!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var loanTextField: UITextField!
    @IBOutlet weak var termTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var stampDuty: UILabel!
    @IBOutlet weak var loanToValue: UILabel!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
    }
    
    func addTransparanetView(frames: CGRect) {
            let window = UIApplication.shared.keyWindow
            transparentView.frame = window?.frame ?? self.view.frame
            self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
            
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
            transparentView.addGestureRecognizer(tapgesture)
            transparentView.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: CGFloat(self.dataSource.count * 50))
            }, completion: nil)
        }
        
        @objc func removeTransparentView() {
            let frames = selectedButton.frame
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.transparentView.alpha = 0
                self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0)
            }, completion: nil)
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
    
    //comment

    
    func calculateStampDuty() {
        
        let propertyValue = Double (valueTextField.text!) ?? 0.0
        
        if borrowingDropdown.currentTitle == "Home Purchase" && propertyValue > 1500000 {
            let bandFourTop = propertyValue - 1500000
            let bandFourPercentage = (bandFourTop * 12) / 100
            let bandFourTotal = 33750 + 57500 + bandFourPercentage
            stampDuty.text = "£" + String(format: "%.2f", Double(bandFourTotal))
        } else if borrowingDropdown.currentTitle == "Home Purchase" && propertyValue > 925000 && propertyValue <= 1500000 {
            let bandThreeTop = propertyValue - 925000
            let bandThreePercentage = (bandThreeTop * 10) / 100
            let bandThreeTotal = 33750 + bandThreePercentage
            stampDuty.text = "£" + String(format: "%.2f", Double(bandThreeTotal))
        } else if borrowingDropdown.currentTitle == "Home Purchase" && propertyValue > 250000 && propertyValue <= 925000 {
            let bandTwoTop = propertyValue - 250000
            let bandTwoPercentage = (bandTwoTop * 5) / 100
            stampDuty.text = "£" + String(format: "%.2f", Double(bandTwoPercentage))
        } else if borrowingDropdown.currentTitle == "Home Purchase" && propertyValue <= 250000 {
            stampDuty.text = "£" + String(format: "%.2f", 0)
        } else {
            print("Fail")
        }
        
    }
    
    func calculateLTV() {
        
        let loan = Double (loanTextField.text!) ?? 0.0
        let value = Double (valueTextField.text!) ?? 0.0
        
        let ltv = (loan/value) * 100
        
        loanToValue.text = String(format: "%.1f", Double(ltv)) + "%"
        
    }
        
    @IBAction func dropdownClicked(_ sender: Any) {
        dataSource = ["First Time Buyer", "Home Purchase", "Remortgage"]
        selectedButton = borrowingDropdown
        addTransparanetView(frames: borrowingDropdown.frame)
    }
    
    @IBAction func calculatePressed(_ sender: Any) {
        
            calculateMonthlyRepayment()
            calculateStampDuty()
            calculateLTV()
            
            print("Borrowing Dropdown = \(borrowingDropdown.currentTitle)")
        }
    //comment
    
    

}

extension MortgageCalculator: UITextFieldDelegate {


    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }

}

extension MortgageCalculator: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}

