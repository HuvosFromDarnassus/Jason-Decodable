//
//  MenuViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

import UIKit

class MenuViewController: UICollectionViewController {
    
    private let menuModel: Menu = Menu()
    
    internal override func viewWillAppear(_ animated: Bool) {
        setupViewController()
        setupCollectionCellSize(itemsPerRow: 2, cellHeight: 200)
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuModel.getItemsCount()
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Menu.numbersIdentifier, for: indexPath) as! MenuViewCell
        
        let cellData = getDataForCell(by: indexPath.row)
        
        let cellImage = UIImage(named: cellData.imageName)
        let cellLabel = cellData.label
        
        configure(&cell, using: cellImage!, cellLabel)
        
        return cell
    }
    
    internal override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemId = menuModel.getItemId(by: indexPath.row)
        performSegue(withIdentifier: itemId, sender: self)
    }
    
    private func configure(_ cell: inout MenuViewCell, using image: UIImage, _ label: String) {
        cell.setImage(image)
        cell.setLabel(label)
    }
    
    private func getDataForCell(by index: Int) -> (imageName: String, label: String) {
        let cellImageName = menuModel.getItemImageName(by: index)
        let cellLabel = menuModel.getItemLabel(by: index)
        
        return (imageName: cellImageName, label: cellLabel)
    }
    
    private func setupCollectionCellSize(itemsPerRow: Int, cellHeight: Int) {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds
        let itemSize = CGSize(width: Int(screenSize.width) / itemsPerRow - 1, height: cellHeight)
        
        setupCellLayout(using: &layout, itemSize)
        
        self.collectionView.collectionViewLayout = layout
    }
    
    private func setupCellLayout(using layout: inout UICollectionViewFlowLayout, _ itemSize: CGSize) {
        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
    }
    
    private func setupViewController() {
        title = Constants.Menu.Title.menu
    }
}
