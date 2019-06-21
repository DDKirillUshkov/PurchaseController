//
//  Receipt.swift
//  PurchaseController
//
//  Copyright © 2019 dashdevs.com. All rights reserved.
//

import Foundation

enum ReceiptType: String, Codable {
    case sandbox = "Sandbox"
    case production = "Production"
    case productionSandbox = "ProductionSandbox"
}

public struct Receipt: Codable {
    
    private struct Constants {
        static let thousand: Double = 1000
    }
    /// Receipt Creation Date - The date when the app receipt was created.
    /// When validating a receipt, use this date to validate the receipt’s signature.
    let receiptCreationDate: Date?
    /// Receipt Creation Date - The date when the app receipt was created.
    let receiptCreationDatePst:  String?
    /// Receipt Creation Date - The date when the app receipt was created.
    let receiptCreationDateMs: Date?
    /// The date that the app receipt expires.
    let receiptExpirationDate: Date?
    /// Original Purchase Date - For a transaction that restores a previous transaction, the date of the original transaction.
    let originalPurchaseDate: String?
    /// Original Purchase Date - For a transaction that restores a previous transaction, the date of the original transaction.
    let originalPurchaseDatePst: String?
    /// Original Purchase Date - For a transaction that restores a previous transaction, the date of the original transaction.
    let originalPurchaseDateMs: Date?
    let requestDate: String?
    let requestDatePst: String?
    let receiptType: ReceiptType?
    let requestDateMs: Date?
    /// App Item ID - A string that the App Store uses to uniquely identify the application that created the transaction.
    let appItemId: Int?
    /// Bundle Identifier - The app’s bundle identifier.
    let bundleId: String
    let adamId: Int?
    /// External Version Identifier - An arbitrary number that uniquely identifies a revision of your application.
    let versionExternalIdentifier: Int?
    /// App Version - The app’s version number.
    let applicationVersion: String
    /// Original Application Version - The version of the app that was originally purchased.
    /// In the sandbox environment, the value of this field is always “1.0”.
    let originalApplicationVersion: String
    let downloadId: Int?
    ///In-App Purchase Receipt - The receipt for an in-app purchase. Note: An empty array is a valid receipt.
    let inApp: [InAppPurchase]?
    
    init?(bundleIdentifier: String?,
          appVersion: String?,
          originalAppVersion: String?,
          inAppPurchaseReceipts: [InAppPurchase],
          receiptCreationDate: Date?,
          expirationDate: Date?) {
        guard let bundleIdentifier = bundleIdentifier,
            let appVersion = appVersion,
            let originalAppVersion = originalAppVersion,
            let receiptCreationDate = receiptCreationDate else {
                return nil
        }
        
        self.bundleId = bundleIdentifier
        self.applicationVersion = appVersion
        self.originalApplicationVersion = originalAppVersion
        self.inApp = inAppPurchaseReceipts
        self.receiptCreationDate = receiptCreationDate
        self.receiptExpirationDate = expirationDate
        
        self.receiptCreationDateMs = nil
        self.receiptCreationDatePst = nil
        self.originalPurchaseDate = nil
        self.originalPurchaseDateMs = nil
        self.originalPurchaseDatePst = nil
        self.requestDate = nil
        self.requestDateMs = nil
        self.requestDatePst = nil
        self.appItemId = nil
        self.adamId = nil
        self.versionExternalIdentifier = nil
        self.downloadId = nil
        self.receiptType = nil
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestDatePst = try values.decode(String.self, forKey: .requestDatePst)
        receiptCreationDatePst = try values.decode(String.self, forKey: .receiptCreationDatePst)
        
        if let receiptCreationDateStr = try values.decodeIfPresent(String.self, forKey: .receiptCreationDate) {
            receiptCreationDate = DateFormatter.appleValidator.date(from: receiptCreationDateStr)
        } else {
            receiptCreationDate = nil
        }
        
        if let receiptExprationDateStr = try values.decodeIfPresent(String.self, forKey: .receiptExpirationDate) {
            receiptExpirationDate = DateFormatter.appleValidator.date(from: receiptExprationDateStr)
        } else {
            receiptExpirationDate = nil
        }
        
        originalPurchaseDatePst = try values.decode(String.self, forKey: .originalPurchaseDatePst)
        originalPurchaseDate = try values.decode(String.self, forKey: .originalPurchaseDate)
        receiptType = try values.decodeIfPresent(ReceiptType.self, forKey: .receiptType)
        appItemId = try values.decode(Int.self, forKey: .appItemId)
        bundleId = try values.decode(String.self, forKey: .bundleId)
        if let creationDateString = try? values.decode(String.self, forKey: .receiptCreationDateMs),
            let seconds = TimeInterval(millisecondsString: creationDateString) {
            receiptCreationDateMs = Date(timeIntervalSince1970: seconds)
        } else {
            receiptCreationDateMs = nil
        }
        if let purchaseDateString = try? values.decode(String.self, forKey: .originalPurchaseDateMs),
            let seconds = TimeInterval(millisecondsString: purchaseDateString) {
            originalPurchaseDateMs = Date(timeIntervalSince1970: seconds)
        } else {
            originalPurchaseDateMs = nil
        }
        adamId = try values.decode(Int.self, forKey: .adamId)
        requestDate = try values.decode(String.self, forKey: .requestDate)
        
        versionExternalIdentifier = try values.decode(Int.self, forKey: .versionExternalIdentifier)
        if let requestDateString = try? values.decode(String.self, forKey: .requestDateMs),
            let seconds = TimeInterval(millisecondsString: requestDateString) {
            requestDateMs = Date(timeIntervalSince1970: seconds)
        } else {
            requestDateMs = nil
        }
        applicationVersion = try values.decode(String.self, forKey: .applicationVersion)
        originalApplicationVersion = try values.decode(String.self, forKey: .originalApplicationVersion)
        downloadId = try values.decode(Int.self, forKey: .downloadId)
        inApp = try? values.decode([InAppPurchase].self, forKey: .inApp)
    }
    
    enum CodingKeys: String, CodingKey {
        case receiptCreationDate = "receipt_creation_date"
        case receiptCreationDatePst = "receipt_creation_date_pst"
        case receiptCreationDateMs = "receipt_creation_date_ms"
        case receiptExpirationDate = "expiration_date"
        case originalPurchaseDate = "original_purchase_date"
        case originalPurchaseDatePst = "original_purchase_date_pst"
        case originalPurchaseDateMs = "original_purchase_date_ms"
        case requestDate = "request_date"
        case requestDatePst = "request_date_pst"
        case receiptType = "receipt_type"
        case appItemId = "app_item_id"
        case bundleId = "bundle_id"
        case adamId = "adam_id"
        case versionExternalIdentifier = "version_external_identifier"
        case requestDateMs = "request_date_ms"
        case applicationVersion = "application_version"
        case originalApplicationVersion = "original_application_version"
        case downloadId = "download_id"
        case inApp = "in_app"
    }
}
