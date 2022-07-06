//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

let COIN_API_KEY = "7003A684-EBBD-49D3-BD39-40CB5FC1F82B"

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(COIN_API_KEY)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            // create a URLSession
            let session = URLSession(configuration: .default)
            
            // give session a task
            // this uses a trailing closure
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                // optional binding with data to safeData
                if let safeData = data {
                    // call parseJSON from self. since this is inside a closure
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(self, coin)
                    }
                }
            }
            
            // start task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let time = decodedData.time
            let coinSymbol = decodedData.asset_id_base
            let currencyPairSymbol = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coin = CoinModel(time: time, coinSymbol: coinSymbol, currencyPairSymbol: currencyPairSymbol, rate: rate)
            
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
