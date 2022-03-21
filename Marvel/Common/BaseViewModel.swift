//
//  BaseViewModel.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
protocol BaseViewModel : HandleResult {
    var onSuccess: (() -> Void)? { get }
    var onFailure: ((_ type: ErrorType) -> Void)? { get }
}

extension BaseViewModel {
    var networkManager : NetworkRequest {
        return .init(.init())
    }
}
