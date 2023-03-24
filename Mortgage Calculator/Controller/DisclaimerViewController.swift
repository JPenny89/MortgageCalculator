//
//  DisclaimerViewController.swift
//  Mortgage Calculator
//
//  Created by James Penny on 09/03/2023.
//

import UIKit

class DisclaimerViewController: UIViewController {
    
    let mintGreen = UIColor(hex: "#319e76ff")
    let lightYellow = UIColor(hex: "#fffd9cff")
    let mediumYellow = UIColor(hex: "#ffec64ff")
    let darkYellow = UIColor(hex: "#ffe135ff")
    
    @IBOutlet weak var disclaimerTitle: UILabel!
    @IBOutlet weak var disclaimerText: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        view.backgroundColor = mintGreen
        disclaimerText.textColor = mintGreen
        disclaimerTitle.textColor = mintGreen
        dismissButton.tintColor = mintGreen
        
        
        

        
    }
    
    
    
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
