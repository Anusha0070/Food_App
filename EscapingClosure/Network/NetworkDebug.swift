//
//  NetworkDebug.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/9/24.
//

import Foundation

class NetworkDebug: NetworkProtocol {
    
    static let sharedInstance = NetworkDebug()
    
    func getData<T: Decodable>(from url: String, completion: @escaping (T) -> Void) {
        
        do {
            let receivedData = try JSONDecoder().decode(T.self, from: FoodJsonData.init().foodJSON)
            completion(receivedData)
        } catch {
            print("Unable to decode json data to the Food structure \(error)")
        }
        
    }
    
}
