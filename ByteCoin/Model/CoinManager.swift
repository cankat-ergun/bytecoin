//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinValue(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"

    let headers = [
        "X-CoinAPI-Key": "67DAC05F-AF8F-4638-A509-0C0EDCB3364E",
        "Accept": "application/json",
    ]
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR","TRY"]
    
    func fetchCoin(_ currencyTheUserPicked: String) {
        let url = "\(baseURL)\(currencyTheUserPicked)"
        print(url)
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if (error != nil) {
                delegate?.didFailWithError(error: error!)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if let safeCoin = data {
                        if let coin = parseJSON(safeCoin) {
                            delegate?.didUpdateCoinValue(self, coin: coin)                        }
                        
                    }
                }
            }
            
        })
        
        dataTask.resume()
    }
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do { // do hast
            let decodedData = try decoder.decode(CoinData.self, from: coinData) // to make it not an object but a data type put .self notation after it
            let currencyName = decodedData.asset_id_quote
            let currencyRate = decodedData.rate
            
            let coin = CoinModel(currencyRate: currencyRate, currencyName: currencyName)
            
            return coin
            
        } catch {
            print(error)
            return nil
        }
    }
}
