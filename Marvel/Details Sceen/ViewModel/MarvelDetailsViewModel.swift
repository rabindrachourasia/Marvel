//
//  MarvelDetailsViewModel.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
class MarvelDetailsViewModel: NSObject, BaseViewModel {
    var onSuccess: (() -> Void)?
    var onFailure: ((_ type: ErrorType) -> Void)?
    var marvelCharacterDetails : [MarvelListResult] = []{
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
                self?.marvelCharacterDetails = detailsData.data?.results ?? []
            }, failure: self?.onFailure)
        }
    }
}
