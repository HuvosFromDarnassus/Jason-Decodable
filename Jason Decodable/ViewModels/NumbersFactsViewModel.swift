//
//  NumbersFactsViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 18.07.2022.
//

import UIKit

class NumbersFactsViewModel {
    public var result: Dynamic = Dynamic("")
    
    public func requestFact(about number: String) {
        let urlString = "\(Constants.API.numbersAPI)\(number)?json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            self.convert(data, to: Numbers.self)
        }.resume()
    }
    
    private func convert(_ data: Data?, to type: Numbers.Type) {
        guard let data = data else { return }
        
        do {
            let fact = try JSONDecoder().decode(type, from: data)
            self.result.value = fact.text
        } catch {
            print(error)
        }
    }
}
