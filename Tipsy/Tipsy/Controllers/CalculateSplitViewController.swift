//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculateSplitViewController: UIViewController {
    var calculatorBill = CalculateBill()
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepperButtons: UIStepper!
    
    func deselect() {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        billTextField.endEditing(true)
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        deselect()
        sender.isSelected = true
        calculatorBill.setTipValue(sender.currentTitle!)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        if billTextField.text != nil && splitNumberLabel.text != nil && calculatorBill.splitBill?.tipValue! != nil {
            print("here")
            calculatorBill.setBill(bill: Float(billTextField.text!)!, split: Float(splitNumberLabel.text!)!)
            self.performSegue(withIdentifier: "goToResults", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            let (totalPerPerson, split, tipPercentage) = calculatorBill.getResult()
            destinationVC.totalPerPerson = totalPerPerson
            destinationVC.split = split
            destinationVC.tipPercentage = tipPercentage
        }
    }
}

