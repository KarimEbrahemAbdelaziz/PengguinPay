//
//  SupportedContriesRepository.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 05/08/2021.
//

import Foundation
import FlagPhoneNumber

enum SupportedContriesRepository {

    case `default`

    var supportedCountriesCodes: [FPNCountryCode] {
        switch self {
        case .default:
            return [.KE, .NG, .TZ, .UG]
        }
    }

    var supportedCountries: [Country] {
        return [
            Country(
                name: "Kenya",
                alpha2Code: "KE",
                alpha3Code: "KES",
                flag: .KE
            ),
            Country(
                name: "Nigeria",
                alpha2Code: "NG",
                alpha3Code: "NGN",
                flag: .NG
            ),
            Country(
                name: "Tanzania",
                alpha2Code: "TZ",
                alpha3Code: "TZS",
                flag: .TZ
            ),
            Country(
                name: "Uganda",
                alpha2Code: "UG",
                alpha3Code: "UGX",
                flag: .UG
            )
        ]
    }
}
