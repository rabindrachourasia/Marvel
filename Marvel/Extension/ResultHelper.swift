//
//  ResultHelper.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
protocol HandleResult : HandleErrors {}

extension HandleResult {
    func handleResult<T: Codable>(result: (Result<T, Error>), success: (( _ type: T) -> Void)?, failure: (( _ type: ErrorType) -> Void)?) {
        switch result {
        case .success(let model):
            success?(model)
        case .failure(let error):
            handleError(callback: failure, error: error)
        }
    }
}
