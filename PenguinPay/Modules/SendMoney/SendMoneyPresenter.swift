//
//  SendMoneyPresenter.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 04/08/2021.
//

import Foundation
import FlagPhoneNumber

protocol SendMoneyPresentationLogic: AnyObject {
    func presentSupportedContries(with supportedContries: [FPNCountryCode])
    func presentExchangeRate(with currency: Currency)
    func presentSendButtonState(isEnabled: Bool)
    func presentReceiverAmount(amount: String)
    func presentLoadingIndicator(isLoading: Bool)
    func presentSuccessEntry()
}

class SendMoneyPresenter {

    let view: SendMoneyView

    init(view: SendMoneyView) {
        self.view = view
    }

}

extension SendMoneyPresenter: SendMoneyPresentationLogic {
    func presentSuccessEntry() {
        view.displaySuccessEntry()
    }

    func presentLoadingIndicator(isLoading: Bool) {
        if isLoading {
            view.showLoadingIndicator()
        } else {
            view.hideLoadingIndicator()
        }
    }

    func presentReceiverAmount(amount: String) {
        var mutableAmount = amount
        while mutableAmount.last == "0" {
            mutableAmount.removeLast()
        }
        if mutableAmount.last == "." {
            mutableAmount.removeLast()
        }
        view.displayReceiverAmount(with: mutableAmount)
    }

    func presentSupportedContries(with supportedContries: [FPNCountryCode]) {
        view.displaySupportedContries(with: supportedContries)
    }

    func presentExchangeRate(with currency: Currency) {
        let exchangeRateValue = "1 BIN = \(currency.exchangeRate) \(currency.sympol)"
        view.displayExchangeRate(with: exchangeRateValue)
    }

    func presentSendButtonState(isEnabled: Bool) {
        view.displayendButtonState(isEnabled: isEnabled)
    }
}
