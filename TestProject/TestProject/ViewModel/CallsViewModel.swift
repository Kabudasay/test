//
//  CallsViewModel.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

protocol TableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}

class CallsViewModel: NSObject, TableViewViewModelType {

    private var apiService: DataFetcherServices!
    private var selectedIndexPath: IndexPath?
    
    var arrayOfCalls : [Request] = []{
        didSet{
            reloadList()
        }
    }
    
    var reloadList = {() -> () in }
    
    override init() {
        super.init()
        self.apiService = DataFetcherServices()
        loadData()
    }
    
    func loadData() {
        self.apiService.dataFetcherCalls { [weak self] (jsonData) in
            
            guard let json = jsonData else { return }
            self!.arrayOfCalls = json.requests!
        }
    }

    func numberOfRows() -> Int {
        return arrayOfCalls.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let sort = arrayOfCalls.sorted { (($0.created?.compare($1.created!))!) == .orderedDescending}
        let objects = sort[indexPath.row]
        return TableViewCellViewModel(json: objects)
    }
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(jsonData: arrayOfCalls[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
  
}


