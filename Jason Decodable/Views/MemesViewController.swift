//
//  MemesViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import UIKit

final class MemesViewController: UIViewController {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var memeTextLabel: UILabel!
    
    private let viewModel: MemesViewModel = MemesViewModel()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.dataRequest(using: "")
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        setupViewController()
    }
    
    @IBAction private func getMemeButtonPressed(_ sender: UIButton) {
        viewModel.getMeme()
    }
    
    
}

// MARK: - ViewModelBindable
extension MemesViewController: ViewModelBindable {
    internal func bindViewModel() {
        viewModel.image.bind { imageData in
            DispatchQueue.main.async {
                self.imageView.isHidden = false
                self.imageView.image = UIImage(data: imageData)
            }
        }
        
        viewModel.text.bind { text in
            DispatchQueue.main.async {
                self.memeTextLabel.isHidden = false
                self.memeTextLabel.text = text
            }
        }
    }
}

// MARK: - ViewControllerSetupable
extension MemesViewController: ViewControllerSetupable {
    internal func setupViewController() {
        title = Constants.Menu.Title.memes
    }
}
