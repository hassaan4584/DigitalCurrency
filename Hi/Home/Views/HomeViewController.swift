//
//  HomeViewController.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailsNavigationCoordinator {

    @IBOutlet weak var currencyListTableview: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    
    private let homeViewModel: HomeVieWModelProtocol
    
    static func createListViewController(homeViewModel: HomeVieWModelProtocol) -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") { aCoder in
            return HomeViewController(homeViewModel: homeViewModel, coder: aCoder)
        }
        return vc
    }
    
    init?(homeViewModel: HomeVieWModelProtocol, coder: NSCoder) {
        self.homeViewModel = homeViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewModelBindings(viewModel: self.homeViewModel)
        self.homeViewModel.fetchCurrencyInformation()
        self.title = self.homeViewModel.screenTitle
        currencyListTableview.accessibilityIdentifier = "myUniqueTableViewIdentifier"
    }
    
    func setupViewModelBindings(viewModel: HomeVieWModelProtocol) {
        viewModel.displayItems.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.isLoading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.errorMessage.observe(on: self) { [weak self] in self?.showErrorMessage($0) }
        viewModel.cryptoDetails.observe(on: self) { [weak self] selectedDetails in
            guard let selectedDetails = selectedDetails else { return }
            self?.selectCryptoDetails(selectedDetails)
        }
    }
    
    func updateItems() {
//        self.currencyListTableview.reloadSections(IndexSet(integer: 0), with: .left)
        self.currencyListTableview.reloadData()
        self.infoLabel.isHidden = true
        self.currencyListTableview.isHidden = false
    }
    
    /// Based on `shouldShowLoader`, this function will show/hide loader
    private func updateLoading(_ shouldShowLoader: Bool) {
        if shouldShowLoader {
            DotsLoadingIndicator.indicator.show(inView: self.view)
        } else {
            DotsLoadingIndicator.indicator.hide(from: self.view)
        }
    }
    
    /// This would show error message to user
    private func showErrorMessage(_ message: String) {
        self.currencyListTableview.isHidden = true
        self.infoLabel.isHidden = false
        self.infoLabel.text = message
    }

    private func selectCryptoDetails(_ selectedItem: CryptoDetails) {
        self.navigateToCryptoDetailsVC(viewModel: CryptoDetailViewModel(cryptoItemDetails: selectedItem))
    }

    // MARK: - Tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.displayItems.value.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.homeViewModel.displayItems.value.count-1 == indexPath.row {
            self.homeViewModel.showNextPage()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCurrencyListTVCell", for: indexPath) as? HomeCurrencyListTVCell else {
            fatalError()
        }
        cell.currencyNameLabel.text = self.homeViewModel[indexPath.item]?.timeStr
        cell.priceLabel.text = "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.homeViewModel.didSelectDisplayitem(index: indexPath.item)
    }
    

}

