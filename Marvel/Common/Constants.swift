//
//  Constants.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//
import Foundation
struct Constants {
    struct URL {
        static let baseURL = "https://gateway.marvel.com/v1/public"
    }
    
    struct secretKeys {
        static let publicKey = "34a10f6a85c2a873baf4150fa622aa12"
        static let privateKey = "24cff430f80f2e35e2187dea5401d3e5ef4bd03d"
    }
    
    struct alertMsg {
        static let   server_not_responding = "Oops! Looks like the server is not responding.";
        static let character_not_found = "The character you are looking for can't be found in the database.";
        static let  api_keys_not_found = "Your API keys to the Marvel API could not be found, or they are not valid. Add your own API keys in the environment variables of the project if you haven't already.";
       static let  no_internet = "It looks like you are not connected to the internet. Check your connection and try again.";
       
    }
}
