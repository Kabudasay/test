//
//  CallsModel.swift
//  TestProject
//
//  Created by yakuza on 09.02.2021.
//

import Foundation

// MARK: - CallsModel
struct CallsModel: Codable {
    var requests: [Request]?
    
    enum CodingKeys: String, CodingKey {
        case requests
    }
}

// MARK: - Request
struct Request: Codable {
    var id, state: String?
    var client: Client?
    var type, created: String?
    var businessNumber: BusinessNumber?
    var origin: String?
    var favorite: Bool?
    var duration: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case state
        case client
        case type
        case created
        case businessNumber = "businessNumber"
        case origin
        case favorite
        case duration
    }
}

// MARK: - BusinessNumber
struct BusinessNumber: Codable {
    var number, label: String?
    
    enum CodingKeys: String, CodingKey {
        case number
        case label
    }
}

// MARK: - Client
struct Client: Codable {
    var address, name: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case name = "Name"
    }
}

