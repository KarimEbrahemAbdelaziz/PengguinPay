//
//  SendMoneyInteractor.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 04/08/2021.
//

import Foundation
import FlagPhoneNumber

protocol SendMoneyBusinessLogic: AnyObject {
    func setupSupportedContries()
    func changeSelectedCountryCode(to code: String)
    func updateSendButtonState()
    func sendAmountChanged(to amount: String)
    func validPhoneNumberEntered(phoneNumber: String, isValid: Bool)
    func changeFirstName(with firstName: String)
    func changeLastName(with lastName: String)
    func transferAmount()
}

class SendMoneyInteractor {

    let presenter: SendMoneyPresentationLogic
    let repository: ExchangeRateRepository

    private var receiverFirstName = ""
    private var receiverLastName = ""
    private var receiverPhoneNumber = ""
    private var sendAmount = ""
    private var isValidPhoneNumber = false
    private var supportedContries: [Country]
    private var seletedCountryCode: String = ""
    private var selectedCountry: Country
    private var selectedCurrency: Currency = Currency(sympol: "USD", exchangeRate: 1.0) {
        didSet {
            presenter.presentExchangeRate(with: selectedCurrency)
        }
    }

    init(presenter: SendMoneyPresentationLogic, exchangeRateRepository: ExchangeRateRepository) {
        self.presenter = presenter
        self.repository = exchangeRateRepository
        self.supportedContries = SupportedContriesRepository.default.supportedCountries
        self.selectedCountry = self.supportedContries.first!
    }

}

extension SendMoneyInteractor: SendMoneyBusinessLogic {
    func transferAmount() {
        // Do Transaction Logic Here!
        presenter.presentSuccessEntry()
    }

    func changeFirstName(with firstName: String) {
        receiverFirstName = firstName
        updateSendButtonState()
    }

    func changeLastName(with lastName: String) {
        receiverLastName = lastName
        updateSendButtonState()
    }

    func validPhoneNumberEntered(phoneNumber: String, isValid: Bool) {
        receiverPhoneNumber = phoneNumber
        isValidPhoneNumber = isValid
        updateSendButtonState()
    }

    func sendAmountChanged(to amount: String) {
        var mutableAmount = amount
        mutableAmount.removeFirst(4)

        sendAmount = mutableAmount == "000" ? "" : mutableAmount
        updateSendButtonState()

        guard let number = Int(mutableAmount, radix: 2) else { return }

        let recipientAmountInSelectedCountryCurrency = Double((selectedCurrency.exchangeRate * Double(number)))
        guard recipientAmountInSelectedCountryCurrency > 0.0 else {
            return
        }

        let recipientAmount = convertReceiverAmountToBIN(with: recipientAmountInSelectedCountryCurrency)
        presenter.presentReceiverAmount(amount: recipientAmount)
    }

    func updateSendButtonState() {
        let isSendButtonEnabled = !isTextFieldsEmpty && isValidPhoneNumber
        presenter.presentSendButtonState(isEnabled: isSendButtonEnabled)
    }

    func changeSelectedCountryCode(to code: String) {
        seletedCountryCode = code
        updateSelectedCountry()
        fetchExchangeRates()
    }

    func setupSupportedContries() {
        presenter.presentSupportedContries(with: SupportedContriesRepository.default.supportedCountriesCodes)
    }

    func fetchExchangeRates() {
        presenter.presentLoadingIndicator(isLoading: true)
        repository.fetchExchangeRates { [weak self] (result: Result<ExchangeRates, Error>) in
            guard let self = self else { return }

            self.presenter.presentLoadingIndicator(isLoading: false)
            switch result {
            case let .success(exchangeRates):
                self.parseEchangeRates(from: exchangeRates, for: self.selectedCountry)
            case let .failure(error):
                self.handleError(with: error)
            }
        }
    }
}

private extension SendMoneyInteractor {
    var isTextFieldsEmpty: Bool {
        receiverFirstName.isEmpty || receiverLastName.isEmpty || receiverPhoneNumber.isEmpty || sendAmount.isEmpty
    }

    func convertReceiverAmountToBIN(with amount: Double) -> String {
        let amountPowered = Int(amount * pow(2, 32))
        var receiverAmount = String(amountPowered, radix: 2)
        let index = receiverAmount.count - 32
        receiverAmount.insert(".", at: receiverAmount.index(receiverAmount.startIndex, offsetBy: index))
        return receiverAmount
    }

    func parseEchangeRates(from exchangeRates: ExchangeRates, for selectedCountry: Country) {
        let exchangeRate = exchangeRates.rates.first { key, _ -> Bool in
            key == selectedCountry.alpha3Code
        }
        let currency = Currency(sympol: selectedCountry.alpha3Code, exchangeRate: exchangeRate!.value)
        updateSelectedCurrency(with: currency)
    }

    func handleError(with error: Error) {

    }

    func updateSelectedCountry() {
        selectedCountry = supportedContries.first(where: { country -> Bool in
            country.alpha2Code == seletedCountryCode
        })!
    }

    func updateSelectedCurrency(with currency: Currency) {
        selectedCurrency = currency
    }
}
