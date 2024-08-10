//
//  Notifications.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import Foundation

extension Notification.Name {
    static let cashBalanceDidChanged = Notification.Name("cashBalanceDidChanged")
    static let singleTrnDidDeleted = Notification.Name("singleTrnDidDeleted")
    static let languageDidSelected = Notification.Name("languageDidSelected")
    static let currencyDidSelected = Notification.Name("currencyDidSelected")
}
