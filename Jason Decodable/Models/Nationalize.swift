//
//  Nationalize.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

struct Nationalize: Codable {
    let name: String
    let country: [Country]
}

struct Country: Codable {
    let id: String
    let probability: Double

    enum CodingKeys: String, CodingKey {
        case id = "country_id"
        case probability
    }
}
