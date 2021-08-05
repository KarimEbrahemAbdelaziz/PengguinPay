//
//  ExchangeRates.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation

struct ExchangeRates: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}
