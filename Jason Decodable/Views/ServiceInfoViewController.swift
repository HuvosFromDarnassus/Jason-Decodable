//
//  ServiceInfoViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 20.07.2022.
//

import UIKit

class ServiceInfoViewController: UIViewController {
    @IBOutlet weak private var serviceTextField: UITextField!
    @IBOutlet weak private var serviceNameLabel: UILabel!
    @IBOutlet weak private var serviceImage: UIImageView!
    @IBOutlet weak private var serviceDescriptionLabel: UILabel!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    
    private let viewModel: ServiceInfoViewModel = ServiceInfoViewModel()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        title = Constants.Menu.Title.services
    }
    
    @IBAction private func searchButtonPressed(_ sender: UIButton) {
        guard let service = serviceTextField.text else { return }
        
        viewModel.requestInfo(of: service)
    }
    
    private func bindViewModel() {
        viewModel.name.bind { name in
            DispatchQueue.main.async {
                self.serviceNameLabel.isHidden = false
                self.serviceNameLabel.text = name
                self.errorMessageLabel.isHidden = true
            }
        }
        
        viewModel.description.bind { description in
            DispatchQueue.main.async {
                self.serviceDescriptionLabel.isHidden = false
                self.serviceDescriptionLabel.text = description
                self.errorMessageLabel.isHidden = true
            }
        }
        
        viewModel.image.bind { image in
            DispatchQueue.main.async {
                self.serviceImage.isHidden = false
                self.serviceImage.image = image
                self.errorMessageLabel.isHidden = true
            }
        }
        
        viewModel.errorMessage.bind { error in
            DispatchQueue.main.async {
                self.errorMessageLabel.isHidden = false
                self.errorMessageLabel.text = error
            }
        }
    }
}
