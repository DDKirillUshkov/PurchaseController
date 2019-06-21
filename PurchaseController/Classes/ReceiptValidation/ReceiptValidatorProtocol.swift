//  ReceiptValidatorProtocol.swift
//  PurchaseController
//
//  Copyright © 2019 dashdevs.com. All rights reserved.

import Foundation

// MARK: Output
public enum ReceiptValidationResult {
    case success(receipt: Receipt)
    case error(error: Error)
}

/// Defines behavior for a type to be used as receipt validator.
///
/// Common approaches are:
/// - local validation
/// - server-side validation
/// - appStore validation
///
/// # See also
/// [Receipt Validation](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Introduction.html)
public protocol ReceiptValidatorProtocol {
    func validate(completion: @escaping (ReceiptValidationResult) -> Void)
}
