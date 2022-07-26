//
//  MenuViewCell.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

import UIKit

class MenuViewCell: UICollectionViewCell {
    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var itemLabel: UILabel!
    
    public func setImage(_ image: UIImage?) {
        guard let unwrappedImage = image else {
            itemImage.image = UIImage(named: Constants.Menu.Image.numbers)
            return
        }
        
        itemImage.image = unwrappedImage
    }
    
    public func setLabel(_ label: String?) {
        guard let unwrappedLabel = label else {
            itemLabel.text = "Label"
            return
        }
        
        itemLabel.text = unwrappedLabel
    }
}
