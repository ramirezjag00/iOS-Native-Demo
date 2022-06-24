//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    var calculatorBrain = CalculatorBrain()
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculatorBrain.reset()
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let roundedValue = calculatorBrain.round2DecimalPlaces(sender.value)
        heightLabel.text = "\(roundedValue)m"
    }

    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let roundedValue = calculatorBrain.round2DecimalPlaces(sender.value)
        weightLabel.text = "\(roundedValue)Kg"
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        calculatorBrain.calculateBMI(heightLabel.text!, weightLabel.text!)
        
        // start
        // programatically creating ui and pass data between view controllers
            // say there's a constant bmiValue
            // let secondVC = SecondViewController() // existing file
            // secondVC.bmiValue = bmiValue // existing constant in SecondViewController file
            // self.present(secondVC, animated: true, completion: nil) // route to SecondViewController
        // end

        // this class can perform a routing / navigation to goToResults
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            // "as!" - force downcast making the segue.destination as a ResultViewController
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = (calculatorBrain.getResult(0) as? String)
            destinationVC.category = (calculatorBrain.getResult(1) as? String)
            destinationVC.categoryColor = (calculatorBrain.getResult(2) as? UIColor)
        }
    }
    

}

