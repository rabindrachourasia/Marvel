//
//  Helper.swift
//  Marvel
//
//  Created by Rabi Chourasia on 13/03/22.
//

import Foundation
import CryptoKit
protocol Md5Hash {
}

extension Md5Hash{
    func hashKey() -> (ts: String, key: String){
        let timestamp = String(Date.currentTimeStamp)
        return (timestamp, md5Hash(timestamp + Constants.secretKeys.privateKey + Constants.secretKeys.publicKey) ?? "")
    }
   private func md5Hash(_ source: String) -> String? {
        guard let data = source.data(using: .utf8) else { return nil }
        return Insecure.MD5.hash(data: data).map { String(format: "%02hhx", $0) }.joined()
    }

    private func format(_ timestamp: TimeInterval) -> String {
        String(Int(timestamp))
    }
    
}
extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
