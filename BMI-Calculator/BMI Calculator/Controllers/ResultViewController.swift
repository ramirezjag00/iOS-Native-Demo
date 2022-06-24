//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Andrey Ramirez on 6/24/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var bmiValue: String?
    var category: String?
    var categoryColor: UIColor?

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = bmiValue!
        adviceLabel.text = category!
        backgroundView.backgroundColor = categoryColor!
    }

    @IBAction func RecalculatePressed(_ sender: UIButton) {
        // navigation.goBack()
        self.dismiss(animated: true, completion: nil)
    }
}
