//
//  Networking.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation
protocol Networking {
    func request(getURL: String, parameters: String, method: String, complition: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
// MARK: - reuqest
  func request(getURL: String, parameters: String, method: String, complition: @escaping (Data?, Error?) -> Void){

        guard let url = URL(string: getURL) else { return }
        var request = URLRequest(url: url)
        let postString = parameters
        if postString != "" {
            request.httpMethod = "POST"
            request.httpBody = postString.data(using: String.Encoding.utf8);
        }
        let task = createDataTaskPost(from: request, complition: complition)
        task.resume()

    }
    
    private func createDataTaskGet(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async{
                complition(data, error)
            }
        }
        
    }
    
    private func createDataTaskPost(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async{
                complition(data, error)
            }
        })
        
    }
    
}
