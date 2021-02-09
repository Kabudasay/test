//
//  TableViewCellViewModel.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

class TableViewCellViewModel: TableViewCellViewModelType {

    private var jsonData: Request
    
    var name: String {
        return jsonData.client?.name ?? ""
    }
    
    var phone: String {
        return jsonData.client?.address ?? ""
    }
    
    var duration: String {
        return jsonData.duration ?? ""
    }
    
    var created: String {
        return jsonData.created ?? ""
    }
    
    init(json: Request) {
        self.jsonData = json
    }

}
