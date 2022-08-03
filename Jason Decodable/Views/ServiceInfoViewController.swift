//
//  ServiceInfoViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 20.07.2022.
//

import UIKit

final class ServiceInfoViewController: UIViewController {
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
        setupViewController()
    }
    
    @IBAction private func searchButtonPressed(_ sender: UIButton) {
        guard let service = serviceTextField.text else { return }
        viewModel.dataRequest(using: service)
    }
    
    private func applyResultToLabel(using uiLabel: UILabel, result: String, isNotErrorLabel: Bool = true) {
        DispatchQueue.main.async {
            uiLabel.isHidden = false
            uiLabel.text = result
            self.errorMessageLabel.isHidden = isNotErrorLabel
        }
    }
}

// MARK: - ViewModelBindable
extension ServiceInfoViewController: ViewModelBindable {
    internal func bindViewModel() {
        viewModel.name.bind { name in
            self.applyResultToLabel(using: self.serviceNameLabel, result: name)
        }
        
        viewModel.description.bind { description in
            self.applyResultToLabel(using: self.serviceDescriptionLabel, result: description)
        }
        
        viewModel.errorMessage.bind { error in
            self.applyResultToLabel(using: self.errorMessageLabel, result: error, isNotErrorLabel: false)
        }
        
        viewModel.image.bind { image in
            DispatchQueue.main.async {
                self.serviceImage.isHidden = false
                self.serviceImage.image = image
                self.errorMessageLabel.isHidden = true
            }
        }
    }
}

// MARK: - ViewControllerSetupable
extension ServiceInfoViewController: ViewControllerSetupable {
    internal func setupViewController() {
        title = Constants.Menu.Title.services
    }
}
