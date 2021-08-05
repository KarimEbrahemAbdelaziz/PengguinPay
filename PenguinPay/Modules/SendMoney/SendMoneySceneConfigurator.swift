//
//  SendMoneySceneConfigurator.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 04/08/2021.
//

import Foundation

class SendMoneySceneConfigurator {
    func configure() -> SendMoneyViewController {
        let viewController = SendMoneyViewController()
        let presenter = SendMoneyPresenter(view: viewController)
        let repository = ExchangeRateRequest()
        let interactor = SendMoneyInteractor(presenter: presenter, exchangeRateRepository: repository)
        viewController.interactor = interactor
        return viewController
    }
}
