//
//  MarvelDetailsViewModel.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
class MarvelDetailsViewModel: NSObject, BaseViewModel {

   // private let networkManager : NetworkRequest = .init(.init())

    var onSuccess: (() -> Void)?
    var onFailure: ((_ type: ErrorType) -> Void)?

    var marvalDetails : [MarvelListResult] = []{
        didSet{
            onSuccess?()
        }
    }
    override init() {
        super.init()
    }

    func getListDetails(id: Int){
        networkManager.details(id: id) { [weak self] (result) in
            self?.handleResult(result: result, success: { (detailsData) in
                self?.marvalDetails = detailsData.data?.results ?? []
            }, failure: self?.onFailure)
        }
    }
}
