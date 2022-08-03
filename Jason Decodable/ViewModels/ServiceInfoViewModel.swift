//
//  ServiceInfoViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 20.07.2022.
//

import UIKit

final class ServiceInfoViewModel: ViewModel {
    public var name: Dynamic = Dynamic("")
    public var description: Dynamic = Dynamic("")
    public var image: Dynamic = Dynamic(UIImage())
    public var errorMessage: Dynamic = Dynamic("")
    
    private func sendResults(using serviceInfo: ServiceInfo) {
        self.name.value = serviceInfo.metadata.name
        self.description.value = serviceInfo.metadata.description
        
        let imageUrl = serviceInfo.metadata.images[0]
        self.getServiceImage(by: imageUrl)
    }
    
    private func getServiceImage(by urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            if let image = UIImage(data: data) {
                self.image.value = image
            }
        }.resume()
    }
}

// MARK: - DataRequestable
extension ServiceInfoViewModel: DataRequestable {
    public func dataRequest(using service: String) {
        guard let url = URL(string: "\(Constants.API.serviceInfoAPI)\(service)") else { return }
        
        request(using: url) { responseData in
            do {
                let serviceInfo = try JSONDecoder().decode(ServiceInfo.self, from: responseData)
                self.sendResults(using: serviceInfo)
            } catch {
                print(error)
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
