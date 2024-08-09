//
//  HelperExtensions.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev

import UIKit

// Put this piece of code anywhere you like to hide default keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SetPasscodeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.utf16.count == 4 && !string.isEmpty {
            return false
        } else {
            return true
        }
    }
    
}

extension Formatter {
    static let number = NumberFormatter()
}
extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let koreaKR: Locale = .init(identifier: "ko_KR")
    static let russianRU: Locale = .init(identifier: "ru_RU")
    static let uzbek: Locale = .init(identifier: "uz_Latn_UZ")
    // ... and so on
}
extension Numeric {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
    // Localized
    var currency:   String { formatted(style: .currency) }
    // Fixed locales
    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
    var currencyKR: String { formatted(style: .currency, locale: .koreaKR) }
    var currencyRU: String { formatted(style: .currency, locale: .russianRU) }
    var currencyUZ: String { formatted(style: .currency, locale: .uzbek) }

}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

