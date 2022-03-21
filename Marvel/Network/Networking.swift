//
//  Networking.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//
import UIKit

public protocol Networking {
    func getJSON<T: Codable>(url: String,  handler: @escaping (_ result: Result<T, Error>) -> Void)
}
