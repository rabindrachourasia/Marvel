//
//  ErrorHelper.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
protocol HandleErrors {
    
}

extension HandleErrors {
    func handleError(callback: ((_ type: ErrorType) -> Void)?, error: Error) {
        switch  error._code {
            case -1009:
                callback?(.noInternet)
            case 409:
                callback?(.missingAPIKey)
            default:
                callback?(.other)
        }
    }
}
enum ErrorType {
    case noInternet
    case other
    case missingAPIKey
}
