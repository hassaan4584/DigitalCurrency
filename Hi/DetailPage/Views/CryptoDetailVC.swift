//
//  CryptoDetailVC.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import UIKit

class CryptoDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var digitalCurrencyNameLabel: UILabel!
    @IBOutlet weak var digitalCurrencyCodeLabel: UILabel!
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var marketCodeLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var lastUpdatedTimezoneLabel: UILabel!
    
    @IBOutlet weak var currencyDetailsTableview: UITableView!
    
    private let cryptoDetailsViewModel: CryptoDetailViewModelProtocol
    
    private static let storyboardIdentifier = "CryptoDetailVC"
    
    static func createCryptoDetailsScreen(viewModel: CryptoDetailViewModelProtocol) -> CryptoDetailVC {
        let storyboard = UIStoryboard(name: "CryptoDetails", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(identifier: self.storyboardIdentifier) { aCoder in
            return CryptoDetailVC(detailsViewModel: viewModel, coder: aCoder)
        }
        return detailsVC
    }
    
    init?(detailsViewModel: CryptoDetailViewModelProtocol, coder: NSCoder) {
        self.cryptoDetailsViewModel = detailsViewModel
        super.init(coder: coder)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.cryptoDetailsViewModel.screenTitle
        self.updateViews(with: self.cryptoDetailsViewModel.cryptoItem.metadata)
        self.currencyDetailsTableview.estimatedRowHeight = 70
        self.currencyDetailsTableview.rowHeight = UITableView.automaticDimension
    }
    
    func updateViews(with metadata: DigitalCurrencyMetadata) {
        self.digitalCurrencyNameLabel.text = metadata.the3DigitalCurrencyName
        self.digitalCurrencyCodeLabel.text = "(\(metadata.digitalCurrencyCode))"
        self.marketNameLabel.text = metadata.the5MarketName
        self.marketCodeLabel.text = "(\(metadata.the4MarketCode)"
        self.lastUpdatedLabel.text = metadata.the6LastRefreshed
        self.lastUpdatedTimezoneLabel.text = "(\(metadata.the7TimeZone))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoDetailsViewModel.detailItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListDetailsItemTVCell", for: indexPath) as? CurrencyListDetailsItemTVCell else { fatalError() }
        
        let data = self.cryptoDetailsViewModel.detailItemsList[indexPath.row]
        cell.setCellData(key: data.key, value: data.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
