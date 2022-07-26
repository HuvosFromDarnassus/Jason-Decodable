//
//  ServiceInfoViewModel.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 20.07.2022.
//

import UIKit

class ServiceInfoViewModel {
    public var name: Dynamic = Dynamic("")
    public var description: Dynamic = Dynamic("")
    public var image: Dynamic = Dynamic(UIImage())
    public var errorMessage: Dynamic = Dynamic("")
    
    public func requestInfo(of service: String) {
        guard let url = URL(string: "\(Constants.API.serviceInfoAPI)\(service)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let serviceInfo = try JSONDecoder().decode(ServiceInfo.self, from: data)
                self.sendResults(using: serviceInfo)
            } catch {
                print(error)
                self.errorMessage.value = error.localizedDescription
            }
        }.resume()
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
    
    private func sendResults(using serviceInfo: ServiceInfo) {
        self.name.value = serviceInfo.metadata.name
        self.description.value = serviceInfo.metadata.description
        
        let imageUrl = serviceInfo.metadata.images[0]
        self.getServiceImage(by: imageUrl)
    }
}
