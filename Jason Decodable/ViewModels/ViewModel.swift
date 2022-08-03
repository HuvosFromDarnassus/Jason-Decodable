//
//  ViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 03.08.2022.
//

import UIKit
import Foundation

class ViewModel {
    internal func request(using url: URL, decodeData: @escaping (_ responseData: Data) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let responseData = data else { return }
            
            decodeData(responseData)
        }.resume()
    }
}
