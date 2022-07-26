//
//  NumberFactsViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 18.07.2022.
//

import UIKit

final class NumberFactsViewController: UIViewController {
    @IBOutlet weak private var resultLabel: UILabel!
    @IBOutlet weak private var textField: UITextField!
    
    private let viewModel: NumbersFactsViewModel = NumbersFactsViewModel()
    
    private var isTextFieldValueValid: Bool {
        return textField.text != nil && textField.text != ""
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        setupViewController()
    }
    
    @IBAction private func getFactButtonPressed(_ sender: UIButton) {
        if isTextFieldValueValid {
            let number = textField.text
            viewModel.dataRequest(using: number!)
        }
    }
}

// MARK: - ViewModelBindable
extension NumberFactsViewController: ViewModelBindable {
    internal func bindViewModel() {
        viewModel.result.bind { fact in
            DispatchQueue.main.async {
                self.resultLabel.isHidden = false
                self.resultLabel.text = fact
            }
        }
    }
}

// MARK: - ViewControllerSetupable
extension NumberFactsViewController: ViewControllerSetupable {
    internal func setupViewController() {
        title = Constants.Menu.Title.numbers
    }
}
