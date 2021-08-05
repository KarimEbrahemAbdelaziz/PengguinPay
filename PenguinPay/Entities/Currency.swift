//
//  Currency.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 05/08/2021.
//

import Foundation

class Currency {
    var sympol: String
    var exchangeRate: Double

    init(sympol: String, exchangeRate: Double) {
        self.sympol = sympol
        self.exchangeRate = exchangeRate
    }
}
