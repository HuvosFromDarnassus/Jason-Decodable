//
//  NationViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import UIKit

final class NationViewModel: ViewModel {
    public var result: Dynamic = Dynamic(Nationalize(name: "", country: []))
}

// MARK: - DataRequestable
extension NationViewModel: DataRequestable {
    public func dataRequest(using name: String) {
        guard let url = URL(string: "\(Constants.API.nationAPI)\(name)") else { return }
        
        request(using: url) { responseData in
            do {
                let probability = try JSONDecoder().decode(Nationalize.self, from: responseData)
                self.result.value = probability
            } catch {
                print(error)
            }
        }
    }
}
