//
//  SendMoneyViewController.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 04/08/2021.
//

import UIKit
import FlagPhoneNumber
import SkeletonView
import SwiftEntryKit

protocol SendMoneyView: AnyObject {
    func displaySupportedContries(with supportedContries: [FPNCountryCode])
    func displayExchangeRate(with exchangeRate: String)
    func displayendButtonState(isEnabled: Bool)
    func displayReceiverAmount(with amount: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func displaySuccessEntry()
}

class SendMoneyViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var amountBackgroundView: UIView!
    @IBOutlet private weak var sendAmountTextField: CurrencyTextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: FPNTextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var exchangeRateLabel: UILabel!
    @IBOutlet private weak var receiverAmountLabel: UILabel!

    // MARK: - Properties

    var interactor: SendMoneyBusinessLogic!
    private var countryListViewController: FPNCountryListViewController = FPNCountryListViewController(style: .plain)

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        interactor.updateSendButtonState()
        interactor.setupSupportedContries()
    }

    // MARK: IBActions

    @IBAction private func send(_ sender: UIButton) {
        interactor.transferAmount()
    }
}

// MARK: Private Functions

private extension SendMoneyViewController {
    private func setupUI() {
        configureComponents()
        configureBackgroundColors()
        configureCornerRadius()
        configureShadows()
        configureDelegates()
    }

    private func configureComponents() {
        configurePhoneNumberTextField()
    }

    private func configurePhoneNumberTextField() {
        phoneNumberTextField.displayMode = .list
    }

    private func configureBackgroundColors() {
        configureAmountBackgroundViewBackgroundColor()
    }

    private func configureCornerRadius() {
        configureAmountBackgroundViewCornerRadius()
    }

    private func configureShadows() {
        configureAmountBackgroundViewShdaow()
        configureSendButtonShadow()
    }

    private func configureDelegates() {
        configureFirstNameTextFieldDelegate()
        configureLastNameTextFieldDelegate()
        configurePhoneNumberTextFieldDelegate()
        configureCountryListViewControllerDidSelect()
    }

    private func configureFirstNameTextFieldDelegate() {
        firstNameTextField.delegate = self
    }

    private func configureLastNameTextFieldDelegate() {
        lastNameTextField.delegate = self
    }

    private func configureAmountBackgroundViewBackgroundColor() {
        amountBackgroundView.backgroundColor =  UIColor(red:0.820, green:0.804, blue:0.722, alpha: 1.000)
    }

    private func configureSendButtonBackgroundColor() {
        sendButton.backgroundColor = UIColor.lightGray
    }

    private func configureAmountBackgroundViewCornerRadius() {
        amountBackgroundView.clipsToBounds = true
        amountBackgroundView.layer.cornerRadius = 24
        amountBackgroundView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    private func configureAmountBackgroundViewShdaow() {
        amountBackgroundView.layer.masksToBounds = false
        amountBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        amountBackgroundView.layer.shadowOpacity = 0.5
        amountBackgroundView.layer.shadowOffset = CGSize.zero
        amountBackgroundView.layer.shadowRadius = 10
    }

    private func configureSendButtonShadow() {
        sendButton.layer.cornerRadius = 16
        sendButton.layer.masksToBounds = false
        sendButton.layer.shadowColor = UIColor.lightGray.cgColor
        sendButton.layer.shadowOpacity = 0.6
        sendButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        sendButton.layer.shadowRadius = 5
    }

    private func configurePhoneNumberTextFieldDelegate() {
        phoneNumberTextField.delegate = self
    }

    private func configureCountryListViewControllerDidSelect() {
        countryListViewController.didSelect = { [weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
        }
    }

    @objc private func dismissCountries() {
        countryListViewController.dismiss(animated: true, completion: nil)
    }

    func sendAmountChanged() {
        guard let amount = sendAmountTextField.text else {
            return
        }

        interactor.sendAmountChanged(to: amount)
    }
}

// MARK: -

extension SendMoneyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }

        if textField == firstNameTextField {
            interactor.changeFirstName(with: text)
        } else if textField == lastNameTextField {
            interactor.changeLastName(with: text)
        } else if textField == sendAmountTextField {
            sendAmountChanged()
        }
    }
}

// MARK: - SendMoneyView Functions

extension SendMoneyViewController: SendMoneyView {
    func displaySuccessEntry() {
        let entry = SendSuccessEntry()
        SwiftEntryKit.display(entry: entry, using: SendSuccessEntry.attributes)
    }

    func showLoadingIndicator() {
        exchangeRateLabel.showAnimatedGradientSkeleton()
        receiverAmountLabel.showAnimatedGradientSkeleton()
    }

    func hideLoadingIndicator() {
        exchangeRateLabel.hideSkeleton()
        receiverAmountLabel.hideSkeleton()
    }

    func displayReceiverAmount(with amount: String) {
        receiverAmountLabel.text = amount
    }

    func displayendButtonState(isEnabled: Bool) {
        sendButton.isEnabled = isEnabled
        sendButton.backgroundColor = isEnabled ? UIColor(red:0.478, green:0.847, blue:0.678, alpha: 1.000) : UIColor.lightGray
    }

    func displayExchangeRate(with exchangeRate: String) {
        exchangeRateLabel.text = exchangeRate
        sendAmountChanged()
    }

    func displaySupportedContries(with supportedContries: [FPNCountryCode]) {
        phoneNumberTextField.setCountries(including: supportedContries)
        countryListViewController.setup(repository: phoneNumberTextField.countryRepository)
    }
}

// MARK: - FPNTextFieldDelegate

extension SendMoneyViewController: FPNTextFieldDelegate {
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        guard let phoneNumber = textField.text else { return }
        interactor.validPhoneNumberEntered(phoneNumber: phoneNumber, isValid: isValid)
    }

    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        interactor.changeSelectedCountryCode(to: code)
    }

    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: countryListViewController)
        countryListViewController.title = "Contries"
        countryListViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))
        self.present(navigationViewController, animated: true, completion: nil)
    }
}
