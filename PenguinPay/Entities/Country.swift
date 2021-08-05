//
//  Country.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 05/08/2021.
//

import Foundation
import FlagPhoneNumber

class Country {
    var name: String
    var alpha2Code: String
    var alpha3Code: String
    var flag: FPNCountryCode

    init(name: String, alpha2Code: String, alpha3Code: String, flag: FPNCountryCode) {
        self.name = name
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.flag = flag
    }
}
