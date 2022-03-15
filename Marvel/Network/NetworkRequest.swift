//
//  NetworkRequest.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//

import UIKit

class NetworkRequest : NSObject, Md5Hash {

    var network : Network?
    private var hashObject : (ts: String, key: String)?
    
    init(_ network: Network) {
        super.init()
        self.network = network
        self.hashObject = hashKey()
    }
    
    
    func list(offset: Int, completion: @escaping (Result<MarvelCharacterListModel, Error>) -> Void) {
        guard let md5 = hashObject else { return }
          let timestamp = md5.ts
          let hash = md5.key
        self.network?.getJSON(url: Constants.URL.baseURL + "/characters?ts=\(timestamp)&apikey=\(Constants.secretKeys.publicKey)&hash=\(hash)&offset=\(offset)", handler: completion)
    }
    
    func details(id: Int, completion: @escaping (Result<MarvelCharacterListModel, Error>) -> Void) {
        guard let md5 = hashObject else { return }
          let timestamp = md5.ts
          let hash = md5.key
        self.network?.getJSON(url: Constants.URL.baseURL + "/characters/\(id)?ts=\(timestamp)&apikey=\(Constants.secretKeys.publicKey)&hash=\(hash)", handler: completion)
    }
}
