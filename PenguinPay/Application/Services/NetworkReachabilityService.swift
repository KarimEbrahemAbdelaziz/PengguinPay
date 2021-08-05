//
//  NetworkReachabilityService.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation
import Alamofire
import SwiftEntryKit

class NetworkReachabilityService: ApplicationService {

    let manager = Alamofire.NetworkReachabilityManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        startListeningForReachability()

        return true
    }

    private func startListeningForReachability() {
        manager?.startListening { [weak self] status in
            switch status {
            case .notReachable, .unknown:
                self?.presentNoInternetConnectionEntry()
            case .reachable(.cellular), .reachable(.ethernetOrWiFi):
                self?.dismissNoInternetConnectionEntry()
            }
        }
    }

    private func presentNoInternetConnectionEntry() {
        let entry = NoInternetConnectionEntry()
        SwiftEntryKit.display(entry: entry, using: NoInternetConnectionEntry.attributes)
    }

    private func dismissNoInternetConnectionEntry() {
        SwiftEntryKit.dismiss()
    }
}
