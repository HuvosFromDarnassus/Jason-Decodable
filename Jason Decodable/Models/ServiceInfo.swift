//
//  ServiceInfo.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

struct ServiceInfo: Codable {
    let url: String
    let metadata: Metadata
    
    struct Metadata: Codable {
        let url: String
        let name, description: String
        let images: [String]
    }
}
