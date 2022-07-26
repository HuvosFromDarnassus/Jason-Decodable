//
//  NationViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import UIKit

class NationViewModel {
    public var result: Dynamic = Dynamic(Nationalize(name: "", country: []))
    
    public func requestNationProbabilities(by name: String) {
        let urlString = "\(Constants.API.nationAPI)\(name)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            self.convert(data, to: Nationalize.self)
        }.resume()
    }
    
    private func convert(_ data: Data?, to type: Nationalize.Type) {
        guard let data = data else { return }
        
        do {
            let probability = try JSONDecoder().decode(type, from: data)
            self.result.value = probability
        } catch {
            print(error)
        }
    }
}
