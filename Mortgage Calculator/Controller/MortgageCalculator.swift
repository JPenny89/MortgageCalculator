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
        
        view.largeContentTitle = "Title"
        
        
        

        
        monthlyPayment.text = "£0.00"
        stampDuty.text = "£0"
        loanToValue.text = "0%"
        
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
        
        let monthlyPaymentFigureThousands = monthlyPaymentFigure.thousands()
        
        print(monthlyPaymentFigureThousands)
        
        monthlyPayment.text = "£" + monthlyPaymentFigureThousands
          
    }
    
    

    
    func calculateStampDuty() {
        
        let propertyValue = Double (valueTextField.text!) ?? 0.0
        
        //MARK: - FIRST TIME BUYER (FTB)
        
        if borrowingDropdown.currentTitle == "First Time Buyer" && propertyValue > 1500000 {
            let bandFourTopFTB = propertyValue - 1500000
            let bandFourPercentageFTB = (bandFourTopFTB * 12) / 100
            let bandFourTotalFTB = 33750 + 57500 + bandFourPercentageFTB
            stampDuty.text = "£" + String(format: "%.0f", Double(bandFourTotalFTB))
        } else if borrowingDropdown.currentTitle == "First Time Buyer" && propertyValue > 925000 && propertyValue <= 1500000 {
            let bandThreeTopFTB = propertyValue - 925000
            let bandThreePercentageFTB = (bandThreeTopFTB * 10) / 100
            let bandThreeTotalFTB = 33750 + bandThreePercentageFTB
            stampDuty.text = "£" + String(format: "%.0f", Double(bandThreeTotalFTB))
        } else if borrowingDropdown.currentTitle == "First Time Buyer" && propertyValue > 625000 && propertyValue <= 925000 {
            let bandTwoTopFTB = propertyValue - 625000
            let bandTwoPercentageFTB = ((bandTwoTopFTB * 5) / 100) + 18750
            stampDuty.text = "£" + String(format: "%.0f", Double(bandTwoPercentageFTB))
        } else if borrowingDropdown.currentTitle == "First Time Buyer" && propertyValue > 425000 && propertyValue <= 625000 {
            let bandTwoTopFTB = propertyValue - 425000
            let bandTwoPercentageFTB = (bandTwoTopFTB * 5) / 100
            stampDuty.text = "£" + String(format: "%.0f", Double(bandTwoPercentageFTB))
        }
        
        //MARK: - ADDITIONAL PROPERTY (ADDP)
        
        
        else if borrowingDropdown.currentTitle == "Additional Property" && propertyValue > 1500000 {
            let bandFourTopADDP = propertyValue - 1500000
            let bandFourPercentageADDP = (bandFourTopADDP * 15) / 100
            let bandFourTotalADDP = 7500 + 54000 + 74750 + bandFourPercentageADDP
            stampDuty.text = "£" + String(format: "%.0f", Double(bandFourTotalADDP))
        } else if borrowingDropdown.currentTitle == "Additional Property" && propertyValue > 925000 && propertyValue <= 1500000 {
            let bandThreeTopADDP = propertyValue - 925000
            let bandThreePercentageADDP = (bandThreeTopADDP * 13) / 100
            let bandThreeTotalADDP = 7500 + 54000 + bandThreePercentageADDP
            stampDuty.text = "£" + String(format: "%.0f", Double(bandThreeTotalADDP))
        } else if borrowingDropdown.currentTitle == "Additional Property" && propertyValue > 250000 && propertyValue <= 925000 {
            let bandTwoTopADDP = propertyValue - 250000
            let bandTwoPercentageADDP = (bandTwoTopADDP * 8) / 100
            let bandTwoTotalADDP = 7500 + bandTwoPercentageADDP
            stampDuty.text = "£" + String(format: "%.0f", Double(bandTwoTotalADDP))
        } else if borrowingDropdown.currentTitle == "Additional Property" && propertyValue <= 250000 {
            let bandOnePercentageADDP = (propertyValue * 3) / 100
            stampDuty.text = "£" + String(format: "%.0f", Double(bandOnePercentageADDP))
        }

        //MARK: - BUYING NEXT HOME
        
        
      else if borrowingDropdown.currentTitle == "Moving Home" && propertyValue > 1500000 {
            let bandFourTop = propertyValue - 1500000
            let bandFourPercentage = (bandFourTop * 12) / 100
            let bandFourTotal = 33750 + 57500 + bandFourPercentage
            stampDuty.text = "£" + String(format: "%.0f", Double(bandFourTotal))
        } else if borrowingDropdown.currentTitle == "Moving Home" && propertyValue > 925000 && propertyValue <= 1500000 {
            let bandThreeTop = propertyValue - 925000
            let bandThreePercentage = (bandThreeTop * 10) / 100
            let bandThreeTotal = 33750 + bandThreePercentage
            stampDuty.text = "£" + String(format: "%.0f", Double(bandThreeTotal))
        } else if borrowingDropdown.currentTitle == "Moving Home" && propertyValue > 250000 && propertyValue <= 925000 {
            let bandTwoTop = propertyValue - 250000
            let bandTwoPercentage = (bandTwoTop * 5) / 100
            stampDuty.text = "£" + String(format: "%.0f", Double(bandTwoPercentage))
        } else {
            stampDuty.text = "£" + String(format: "%.0f", 0)
        }
        
    }
    
    func calculateLTV() {
        
        let loan = Double (loanTextField.text!) ?? 0.0
        let value = Double (valueTextField.text!) ?? 0.0
        
        let ltv = (loan/value) * 100
        
        loanToValue.text = String(format: "%.1f", Double(ltv)) + "%"
        
    }
        
    @IBAction func dropdownClicked(_ sender: Any) {
        dataSource = ["First Time Buyer", "Moving Home", "Remortgage       ", "Additional Property"]
        selectedButton = borrowingDropdown
        addTransparanetView(frames: borrowingDropdown.frame)
    }
    
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        calculateMonthlyRepayment()
        calculateStampDuty()
        calculateLTV()
        
    }
    
    

    @IBAction func resetPressed(_ sender: Any) {
        
        borrowingDropdown.titleLabel?.text = "Please Select"
        interestTextField.text = ""
        loanTextField.text = ""
        termTextField.text = ""
        valueTextField.text = ""
        monthlyPayment.text = "£0.00"
        stampDuty.text = "£0"
        loanToValue.text = "0%"
        
    }
    
    
    @IBAction func disclaimerPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToDisclaimer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDisclaimer" {
            let destinationVC = segue.destination as! DisclaimerViewController
        }
    }
    
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

extension Double {
    func thousands() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(for: self) ?? ""
    }
}

