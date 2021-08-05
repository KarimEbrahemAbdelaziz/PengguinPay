//
//  ExchangeRatesRoute.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation
import Alamofire
import Keys

enum ExchangeRatesRoute: URLRequestConvertible {

    case exchangeRate

    static let baseURLString = "https://openexchangerates.org/api"
    static let cocoaPodsKeys = PenguinPayKeys()

    var method: HTTPMethod {
        switch self {
        case .exchangeRate:
            return .get
        }
    }

    var params: [String: Any]? {
        switch self {
        case .exchangeRate:
            return nil
        }
    }

    var headers: [String: String] {
        switch self {
        case .exchangeRate:
            return [
//                "Authorization": ExchangeRatesRoute.cocoaPodsKeys.openExchangeRatesAppId,
                "Accept": "*/*",
                "accept-encoding": "gzip, deflate"
            ]
        }
    }

    var relativePath: String {
        switch self {
        case .exchangeRate:
            return ExchangeRatesRoute.baseURLString + "/latest.json"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .exchangeRate:
            return [
                URLQueryItem(name: "app_id", value: ExchangeRatesRoute.cocoaPodsKeys.openExchangeRatesAppId)
            ]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .exchangeRate:
            return JSONEncoding.default
        }
    }
    

    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents(string: relativePath)
        urlComponents?.queryItems = queryItems
        let url = try? urlComponents?.asURL()

//        let url = URL(string: relativePath)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = HTTPHeaders(headers)

        return try! encoding.encode(urlRequest, with: params)
    }
}
