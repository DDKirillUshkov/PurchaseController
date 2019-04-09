//
//  Receipt.swift
//  PurchaseController
//
//  Copyright © 2019 dashdevs.com. All rights reserved.
//

import Foundation

struct Receipt: Codable {
    
    private struct Constants {
        static let thousand: Double = 1000
    }
    
    let receiptCreationDate: String?
    let receiptCreationDatePst:  String?
    let originalPurchaseDate: String?
    let originalPurchaseDatePst: String?
    let requestDate: String?
    let requestDatePst: String?
    let receiptType: String
    let appItemId: Int
    let receiptCreationDateMs: Date?
    let bundleId: String
    let originalPurchaseDateMs: Date?
    let adamId: Int
    let versionExternalIdentifier: Int
    let requestDateMs: Date?
    let applicationVersion: String
    let originalApplicationVersion: String
    let downloadId: Int
    let inApp: [InApp]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestDatePst = try values.decode(String.self, forKey: .requestDatePst)
        receiptCreationDate = try values.decode(String.self, forKey: .receiptCreationDate)
        receiptCreationDatePst = try values.decode(String.self, forKey: .receiptCreationDatePst)
        originalPurchaseDatePst = try values.decode(String.self, forKey: .originalPurchaseDatePst)
        originalPurchaseDate = try values.decode(String.self, forKey: .originalPurchaseDate)
        receiptType = try values.decode(String.self, forKey: .receiptType)
        appItemId = try values.decode(Int.self, forKey: .appItemId)
        bundleId = try values.decode(String.self, forKey: .bundleId)
        if let creationDateString = try? values.decode(String.self, forKey: .receiptCreationDateMs), let ms = TimeInterval(creationDateString) {
            receiptCreationDateMs = Date(timeIntervalSince1970: ms / Constants.thousand)
        } else {
            receiptCreationDateMs = nil
        }
        if let purchaseDateString = try? values.decode(String.self, forKey: .originalPurchaseDateMs), let ms = TimeInterval(purchaseDateString) {
            originalPurchaseDateMs = Date(timeIntervalSince1970: ms / Constants.thousand)
        } else {
            originalPurchaseDateMs = nil
        }
        adamId = try values.decode(Int.self, forKey: .adamId)
        requestDate = try values.decode(String.self, forKey: .requestDate)
        
        versionExternalIdentifier = try values.decode(Int.self, forKey: .versionExternalIdentifier)
        if let requestDateString = try? values.decode(String.self, forKey: .requestDateMs), let ms = TimeInterval(requestDateString) {
            requestDateMs = Date(timeIntervalSince1970: ms / Constants.thousand)
        } else {
            requestDateMs = nil
        }
        applicationVersion = try values.decode(String.self, forKey: .applicationVersion)
        originalApplicationVersion = try values.decode(String.self, forKey: .originalApplicationVersion)
        downloadId = try values.decode(Int.self, forKey: .downloadId)
        inApp = try values.decode([InApp].self, forKey: .inApp)

    }
    
    enum CodingKeys: String, CodingKey {
        case receiptCreationDate = "receipt_creation_date"
        case receiptCreationDatePst = "receipt_creation_date_pst"
        case originalPurchaseDate = "original_purchase_date"
        case originalPurchaseDatePst = "original_purchase_date_pst"
        case requestDate = "request_date"
        case requestDatePst = "request_date_pst"
        case receiptType = "receipt_type"
        case appItemId = "app_item_id"
        case receiptCreationDateMs = "receipt_creation_date_ms"
        case bundleId = "bundle_id"
        case originalPurchaseDateMs = "original_purchase_date_ms"
        case adamId = "adam_id"
        case versionExternalIdentifier = "version_external_identifier"
        case requestDateMs = "request_date_ms"
        case applicationVersion = "application_version"
        case originalApplicationVersion = "original_application_version"
        case downloadId = "download_id"
        case inApp = "in_app"
    }
    
}
