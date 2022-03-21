//
//  Network.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//
import UIKit

public class Network : Networking {

    private let queue = DispatchQueue(label: "Network.Serial.Queue")
    
    public func getJSON<T>(url: String, handler: @escaping (Result<T, Error>) -> Void) where T : Codable {
        Network.perform(urlString: url, completion: handler)
    }
    
    private class func perform<T: Codable>(urlString: String, completion:@escaping (Result<T, Error>) -> Void) {
        guard let safeURL = URL(string: urlString) else { return }
        var request = URLRequest(url: safeURL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            if let jsonData = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? NSError.init(domain: "something went wrong", code: 404, userInfo: nil)))
            }
        }.resume()
    }
}
