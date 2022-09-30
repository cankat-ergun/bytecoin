//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Argun Cankat Ergun on 1.09.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel: Codable{
    let currencyRate: Double
    let currencyName: String
    var formattedRate: String{
        return String(format: "%.1f", currencyRate)
    }
}
