//
//  Network.swift
//  EscapingClosure
//
//  Created by Anusha Raju on 12/2/24.
//
//Singleton Network Layer
import Foundation

protocol NetworkProtocol {
    func getData(from url: String, completion: @escaping (FoodData) -> Void)
}

class Network: NetworkProtocol {
    static let sharedInstance = Network()
    private init() { }
    
    //MARK: - Get data from the URL
    func getData(from url: String, completion: @escaping (FoodData) -> Void) {
        guard let serverUrl =  URL(string: url) else {
            print("getData: Invalid URL")
            return
        }
        
        //MARK: - Fetch data from server by passing URL object
        URLSession.shared.dataTask(with: URLRequest(url: serverUrl), completionHandler: { data, response, error in
            
            guard let data, error == nil else {
                return print("getData: Error: \(error!.localizedDescription)")
            }
            print("sucessfully fetched data!!")
            
            do {
                let receivedData = try JSONDecoder().decode(FoodData.self, from: data)
                completion(receivedData)
            } catch {
                print("Unable to decode json data to the Food structure \(error)")
            }
        })
        .resume()
    }
}

