//
//  Network.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//
//Singleton Network Layer
import Foundation
import UIKit

protocol NetworkProtocol {
    func getData<T: Decodable>(from url: String, completion: @escaping (T) -> Void)
}

class Network: NetworkProtocol {
    static let sharedInstance = Network()
    private init() { }
    
    //MARK: - Get data from the URL
    func getData<T: Decodable>(from url: String, completion: @escaping (T) -> Void) {
        guard let serverUrl =  URL(string: url) else {
            print("getData: Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: serverUrl), completionHandler: { data, response, error in
            
            guard let data, error == nil else {
                return print("getData: Error: \(error!.localizedDescription)")
            }
            print("sucessfully fetched data!!")
            
            do {
                let receivedData = try JSONDecoder().decode(T.self, from: data)
                completion(receivedData)
            } catch {
                print("Unable to decode json data to the Food structure \(error)")
            }
        })
        .resume()
    }
}

