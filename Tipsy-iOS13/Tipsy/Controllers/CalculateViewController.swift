//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var zeroPercentTipButton: UIButton!
    @IBOutlet weak var tenPercentTipButton: UIButton!
    @IBOutlet weak var twentyPercentTipButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepperControl: UIStepper!
    
    var tip: Float = 0.0
    var amount: Float = 0
    var numberOfPeople: Int = 0
    var finalAmount = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        billAmountTextField.endEditing(true)
        zeroPercentTipButton.isSelected=false
        tenPercentTipButton.isSelected=false
        twentyPercentTipButton.isSelected=false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let ButtonTitleValue = buttonTitle.dropLast()
        tip = Float(ButtonTitleValue)!/100
        
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billTextFieldValue = billAmountTextField.text!
        if billTextFieldValue != ""
        {
            amount = Float(billTextFieldValue)!
            let intermediateAmount = amount*(1 + tip)/Float(numberOfPeople)
            finalAmount = String(format: "%2f", intermediateAmount)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultsViewController
        destinationVC.shareAmount = finalAmount
        destinationVC.tip = Int(tip*100)
        destinationVC.split = numberOfPeople
    }
}
