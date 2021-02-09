//
//  DataFetcherServices.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

class DataFetcherServices {
    
    var networkDataFetcher: NetworkDataFetcher!

    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()){
        self.networkDataFetcher = networkDataFetcher
    }
    
    func dataFetcherCalls(completion: @escaping (CallsModel?) -> Void) {
        let methods = "POST"
        let urlString = "https://5e3c202ef2cb300014391b5a.mockapi.io/testapi"
        let parameters = ""
        networkDataFetcher.fetchGenericJsonData(urlString: urlString, getPostParameters: parameters, method: methods, response: completion)
        
       
    }
    
   

}
