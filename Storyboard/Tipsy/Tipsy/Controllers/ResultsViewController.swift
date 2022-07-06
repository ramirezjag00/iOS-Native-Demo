//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Andrey Ramirez on 6/26/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalPerPerson: String?
    var split: Int?
    var tipPercentage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = "\(totalPerPerson!)"
        settingsLabel.text = "Split between \(split!) people, with \(tipPercentage!) tip."
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
