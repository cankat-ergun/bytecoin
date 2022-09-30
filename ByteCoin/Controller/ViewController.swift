//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var convertedBitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return coinManager.currencyArray.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return coinManager.currencyArray[row]}
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrencyFromPicker = coinManager.currencyArray[row]
        coinManager.fetchCoin(selectedCurrencyFromPicker)
        
        }
    
    
    
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoinValue(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coin.currencyName
            self.convertedBitcoinLabel.text = coin.formattedRate
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

