//
//  Memes.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

struct Memes: Codable {
    let data: DataClass
    
    struct DataClass: Codable {
        let memes: [Meme]
    }
}

struct Meme: Codable {
    let name: String
    let url: String
    let width, height: Int
}
