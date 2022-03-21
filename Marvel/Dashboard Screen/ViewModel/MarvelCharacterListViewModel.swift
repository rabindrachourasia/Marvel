//
//  MarvelCharacterListViewModel.swift
//  Marvel
//
//  Created by Rabi Chourasia on 12/03/22.
//

import Foundation
class MarvelCharacterListViewModel: NSObject, BaseViewModel {
    
    var onSuccess: (() -> Void)?
    var onFailure: ((_ type: ErrorType) -> Void)?
    
    var marvelList : [MarvelListResult] = []{
        didSet{
            onSuccess?()
        }
    }
    override init() {
        super.init()
    }
    
    func getMarvelList(offset: Int){
        networkManager.list(offset: offset) { [weak self] (result) in
            self?.handleResult(result: result, success: { (list) in
                self?.marvelList = list.data?.results ?? []
            }, failure: self?.onFailure)
        }
    }
}
