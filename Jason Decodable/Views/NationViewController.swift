//
//  NationViewController.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 19.07.2022.
//

import UIKit

final class NationViewController: UIViewController {
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var nationsTableView: UITableView!
    
    private let viewModel: NationViewModel = NationViewModel()
    
    private var tableDataItems: [Country] = []
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        setupViewController()
    }
    
    @IBAction private func calculateNationPressed(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        
        viewModel.dataRequest(using: name)
        nameTextField.text = ""
    }
    
    private func countryName(from countryCode: String) -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            return name
        }
        return countryCode
    }
    
    private func setupNavigationBar() {
        title = Constants.Menu.Title.nation
    }
    
    private func setupTableView() {
        nationsTableView.dataSource = self
        nationsTableView.register(UINib(nibName: Constants.tableCellNibName, bundle: nil), forCellReuseIdentifier: Constants.nationTableCellId)
    }
    
    private func showResultFields() {
        self.nameLabel.isHidden = false
        self.nationsTableView.isHidden = false
    }
    
    private func applyResult(using result: Nationalize) {
        self.nameLabel.text = "Name: \(result.name)"
        self.nationsTableView.reloadData()
    }
}

// MARK: - ViewModelBindable
extension NationViewController: ViewModelBindable {
    internal func bindViewModel() {
        viewModel.result.bind { result in
            self.tableDataItems = result.country
            
            DispatchQueue.main.async {
                self.showResultFields()
                self.applyResult(using: result)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NationViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataItems.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.nationTableCellId, for: indexPath) as! NationTableViewCell
        
        if !tableDataItems.isEmpty {
            setupTableCell(using: indexPath.row, &cell)
        }
        
        return cell
    }
    
    private func setupTableCell(using index: Int, _ cell: inout NationTableViewCell) {
        let dataItem = tableDataItems[index]
        let country = getCountryData(by: dataItem.id)
        
        cell.nationNameLabel.text = country
        cell.probabilityBar.progress = Float(dataItem.probability)
        cell.percentLabel.text = "\(Float(dataItem.probability) * 100)"
    }
    
    private func getCountryData(by code: String) -> String {
        let countryName = countryName(from: code)
        
        if let countryFlag = String.emojiFlag(for: code) {
            return "\(countryFlag)\(countryName)"
        }
        
        return countryName
    }
}

// MARK: - ViewControllerSetupable
extension NationViewController: ViewControllerSetupable {
    internal func setupViewController() {
        setupNavigationBar()
        setupTableView()
    }
}

// MARK: - String country flag extension
extension String {
    static public func emojiFlag(for countryCode: String) -> String! {
        let lowercasedCode = countryCode.lowercased()
        
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }
        
        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        
        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        
        return String(indicatorSymbols.map({ Character($0) }))
    }
}
