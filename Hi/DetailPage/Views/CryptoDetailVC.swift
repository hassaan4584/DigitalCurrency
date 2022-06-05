//
//  CryptoDetailVC.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import UIKit

class CryptoDetailVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var digitalCurrencyNameLabel: UILabel!
    @IBOutlet weak var digitalCurrencyCodeLabel: UILabel!
    @IBOutlet weak var marketNameLabel: UILabel!
    @IBOutlet weak var marketCodeLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var lastUpdatedTimezoneLabel: UILabel!

    @IBOutlet weak var currencyDetailsTableview: UITableView!

    private var datasource: UITableViewDiffableDataSource<Int, CurrencyDetailsItem>?
    private let cryptoDetailsViewModel: CryptoDetailViewModelProtocol

    private static let storyboardIdentifier = "CryptoDetailVC"

    // MARK: - Initialization
    static func createCryptoDetailsScreen(viewModel: CryptoDetailViewModelProtocol) -> CryptoDetailVC {
        let storyboard = UIStoryboard(name: AppConstants.StoryboardName.cryptoDetails.rawValue, bundle: nil)
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

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.applySnapshot()
    }

    func setupViews() {
        self.title = self.cryptoDetailsViewModel.screenTitle
        self.configureDatasource()
        self.updateViews(with: self.cryptoDetailsViewModel.cryptoItem.metadata)
        self.currencyDetailsTableview.delegate = self
    }

    func updateViews(with metadata: DigitalCurrencyMetadata) {
        self.digitalCurrencyNameLabel.text = metadata.digitalCurrencyName
        self.digitalCurrencyCodeLabel.text = "(\(metadata.digitalCurrencyCode))"
        self.marketNameLabel.text = metadata.marketName
        self.marketCodeLabel.text = "(\(metadata.marketCode)"
        self.lastUpdatedLabel.text = metadata.lastRefreshed
        self.lastUpdatedTimezoneLabel.text = "(\(metadata.timeZone))"
    }

    // MARK: - Tableview

    /// Configuring tableview with diffable datasource
    private func configureDatasource() {
        let datasource = UITableViewDiffableDataSource<Int, CurrencyDetailsItem>(tableView: currencyDetailsTableview) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListDetailsItemTVCell.reuseIdentifier, for: indexPath) as? CurrencyListDetailsItemTVCell else { fatalError() }
            cell.setCellData(currencyItem: itemIdentifier)
            return cell
        }
        self.datasource = datasource
        self.currencyDetailsTableview.delegate = self
    }

    /// Apply the changes on tableview to reflect new data
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CurrencyDetailsItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.cryptoDetailsViewModel.detailItemsList)
        datasource?.apply(snapshot, animatingDifferences: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
