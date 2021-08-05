//
//  AppDelegateFactory.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation

enum AppDelegateFactory {
    case `default`

    func make() -> ApplicationService {
        return CompositeAppDelegate(
            applicationServices: [
                MainEntryPointService(),
                NetworkReachabilityService(),
            ]
        )
    }
}
