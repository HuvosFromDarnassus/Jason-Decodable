//
//  MemesViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import Foundation
import UIKit

final class MemesViewModel: ViewModel {
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
    
    private func getImageData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
    }
}

// MARK: - DataRequestable
extension MemesViewModel: DataRequestable {
    func dataRequest(using param: String) {
        guard let url = URL(string: Constants.API.memesAPI) else { return }
        
        request(using: url) { responseData in
            do {
                let memes = try JSONDecoder().decode(Memes.self, from: responseData)
                self.memes = memes.data.memes
            } catch {
                print(error)
            }
        }
    }
}
