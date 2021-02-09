//
//  DataFetcher.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJsonData<T: Codable>(urlString: String, getPostParameters: String, method: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
   var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJsonData<T: Codable>(urlString: String, getPostParameters: String, method: String, response: @escaping (T?) -> Void) {
        //print(T.self)
        networking.request(getURL: urlString, parameters: getPostParameters, method: method) { (data, error) in
            
            if let error = error {
                print("Error recived requsting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            return response(decoded)
        }
    }
    
    
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
