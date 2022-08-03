//
//  NumbersFactsViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 18.07.2022.
//

import UIKit

final class NumbersFactsViewModel: ViewModel {
    public var result: Dynamic = Dynamic("")
}

// MARK: - DataRequestable
extension NumbersFactsViewModel: DataRequestable {
    public func dataRequest(using number: String) {
        guard let url = URL(string: "\(Constants.API.numbersAPI)\(number)?json") else { return }
        
        request(using: url) { responseData in
            do {
                let fact = try JSONDecoder().decode(Numbers.self, from: responseData)
                self.result.value = fact.text
            } catch {
                print(error)
            }
        }
    }
}
