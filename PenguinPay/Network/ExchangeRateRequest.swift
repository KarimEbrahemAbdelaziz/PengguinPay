//
//  ExchangeRateRequest.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation
import Alamofire

protocol ExchangeRateRepository: AnyObject {
    func fetchExchangeRates(_ completionHandler: @escaping (Result<ExchangeRates, Error>) -> Void)
}

class ExchangeRateRequest: ExchangeRateRepository {
    func fetchExchangeRates(_ completionHandler: @escaping (Result<ExchangeRates, Error>) -> Void) {

        let fetchExchangeRatesRoute = ExchangeRatesRoute.exchangeRate
        AF.request(fetchExchangeRatesRoute)
            .responseDecodable { (response: DataResponse<ExchangeRates, AFError>) in

            switch response.result {
            case let .success(rates):
                completionHandler(.success(rates))
            case let .failure(error):
                completionHandler(.failure(error))
            }

        }

    }
}
