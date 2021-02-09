//
//  DetailViewModel.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

protocol DetailViewModelType {
    var name: String { get }
}

class DetailViewModel: DetailViewModelType {

    private var json: Request
    
    var name: String {
        return json.client?.name ?? ""
    }
    var phone: String {
        return json.client?.address ?? ""
    }
    
    var duration: String {
        return json.duration ?? ""
    }
    
    var businessName: String {
        return json.businessNumber?.label ?? ""
    }
    
    var businessNumber: String {
        return json.businessNumber?.number ?? ""
    }
    
    init(jsonData: Request) {
        self.json = jsonData
    }
    
    
    
}
