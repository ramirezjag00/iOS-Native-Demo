//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self

        // fetch coin price of first coin pair currency on load
        coinManager.getCoinPrice(for: coinManager.currencyArray[0])
        
    }
}

//MARK: - CoinmanagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.currencyPairSymbol
            self.bitcoinLabel.text = coin.rateString
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    // delegate: required method to know how many columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // delegate: required method to know how many rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    // delegate: required method to know what will be the title per row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // delegate: required method to trigger a selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

