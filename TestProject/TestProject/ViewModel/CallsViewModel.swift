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
    
    
    func saveToJsonFile(array: CallsModel) {
        // Get the url of Persons.json in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("CallsModel.json")

        let personArray =  [["person": ["name": "Dani", "age": "24"]], ["person": ["name": "ray", "age": "70"]]]

        // Create a write-only stream
        guard let stream = OutputStream(toFileAtPath: fileUrl.path, append: false) else { return }
        stream.open()
        defer {
            stream.close()
        }

        // Transform array into data and save it into file
        var error: NSError?
        JSONSerialization.writeJSONObject(personArray, to: stream, options: [], error: &error)

        // Handle error
        if let error = error {
            print(error)
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


