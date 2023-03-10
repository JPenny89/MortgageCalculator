//
//  DisclaimerViewController.swift
//  Mortgage Calculator
//
//  Created by James Penny on 09/03/2023.
//

import UIKit

class DisclaimerViewController: UIViewController {
    
    let mintGreen = UIColor(hex: "#3eb489ff")
    let lightYellow = UIColor(hex: "#fffd9cff")
    let mediumYellow = UIColor(hex: "#ffec64ff")
    let darkYellow = UIColor(hex: "#ffe135ff")
    
    
    @IBOutlet weak var disclaimerText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disclaimerText.textColor = mintGreen
        

        
    }
    
    
    
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
