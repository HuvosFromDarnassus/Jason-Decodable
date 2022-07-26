//
//  MemesViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import Foundation
import UIKit

class MemesViewModel {
    public var text: Dynamic = Dynamic("")
    public var image: Dynamic = Dynamic(Data())
    
    private var memes: [Meme]?
    
    public func getMeme() {
        if let meme = memes?.randomElement() {
            text.value = meme.name
            
            getImageData(from: meme.url) { data, response, error in
                guard let data = data, error == nil else { return }
                self.image.value = data
            }
        }
    }
    
    public func requestMemes() {
        let urlString = Constants.API.memesAPI
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let memes = try JSONDecoder().decode(Memes.self, from: data)
                self.memes = memes.data.memes
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func getImageData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
    }
}
