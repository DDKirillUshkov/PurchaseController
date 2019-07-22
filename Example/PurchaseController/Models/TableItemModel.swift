//
//  TableItemModel.swift
//  PurchaseController
//
//  Copyright © 2019 dashdevs.com. All rights reserved.
//

import Foundation

enum TableItemModel: String {
    
    case consumable
    case nonConsumable
    case autoRenewSubscription
    case nonRenewSubscription
    
    case restore
    case retrieve
    case refreshReceipt
    case validateReceiptLocally
    case validateReceiptRemotely
    case validateSubscription
    
    case newVC
    
    var title: String {
        switch self {
        case .consumable:
            return "Consumable 💰"
        case .nonConsumable:
            return "Non Consumable 💸"
        case .autoRenewSubscription:
            return "Auto Renew Subscription 🤑"
        case .nonRenewSubscription:
            return "Non Renew Subscription 💵"
            
        case .restore:
            return "Restore 💲"
        case .retrieve:
            return "Retrieve 💶"
        case .refreshReceipt:
            return "Refresh receipt 🧾"
        case .validateReceiptLocally:
            return "Validate receipt locally 💴"
        case .validateReceiptRemotely:
            return "Validate receipt remotely 💴"
        case .validateSubscription:
            return "Validate subscription 💴"
        case .newVC:
            return "Show meeee"
        }
    }
    
    var action: Selector {
        switch self {
        case .consumable:
            return #selector(MainViewController.purchaseConsumable)
        case .nonConsumable:
            return #selector(MainViewController.purchaseNonConsumable)
        case .autoRenewSubscription:
            return #selector(MainViewController.purchaseAutoRenewSubscription)
        case .nonRenewSubscription:
            return #selector(MainViewController.purchaseNonRenewSubscription)
            
        case .restore:
            return #selector(MainViewController.restore)
        case .retrieve:
            return #selector(MainViewController.retrieve)
        case .refreshReceipt:
            return #selector(MainViewController.refreshReceipt)
        case .validateReceiptLocally:
            return #selector(MainViewController.validateReceiptLocally)
        case .validateReceiptRemotely:
            return #selector(MainViewController.validateReceiptRemotely)
        case .validateSubscription:
            return #selector(MainViewController.validateSubscription)
        case .newVC:
             return #selector(MainViewController.showNewVC)
        }
    }
}
