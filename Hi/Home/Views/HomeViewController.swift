//
//  HomeViewController.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import UIKit

class HomeViewController: UIViewController, DetailsNavigationCoordinator {

    @IBOutlet weak var currencyListTableview: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var sortTextField: UITextField!
    
    private let pickerView: UIPickerView
    private let homeViewModel: HomeViewModelProtocol
    
    private static let storyboardIdentifier = "HomeViewController"
    
    // MARK: Initializations
    static func createListViewController(homeViewModel: HomeViewModelProtocol) -> HomeViewController {
        let storyboard = UIStoryboard(name: AppConstants.StoryboardName.home.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: self.storyboardIdentifier) { aCoder in
            return HomeViewController(homeViewModel: homeViewModel, coder: aCoder)
        }
        return vc
    }
    
    init?(homeViewModel: HomeViewModelProtocol, coder: NSCoder) {
        self.homeViewModel = homeViewModel
        self.pickerView = UIPickerView()
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.setupViewModelBindings(viewModel: self.homeViewModel)
        self.homeViewModel.fetchCurrencyInformation()
        self.title = self.homeViewModel.screenTitle
    }
    
    private func setupViews() {
        currencyListTableview.rowHeight = UITableView.automaticDimension
        currencyListTableview.estimatedRowHeight = 56
        
        self.sortTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        self.sortTextField.placeholder = self.homeViewModel.currentSorting.sortingName
    }
    
    private func setupViewModelBindings(viewModel: HomeViewModelProtocol) {
        viewModel.displayItems.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.isLoading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.errorMessage.observe(on: self) { [weak self] in self?.showErrorMessage($0) }
        viewModel.sortingTextFieldPlaceholder.observe(on: self) { [weak self] in self?.updateSortingTextFieldPlaceholder($0) }
        viewModel.cryptoDetails.observe(on: self) { [weak self] selectedDetails in
            guard let selectedDetails = selectedDetails else { return }
            self?.selectCryptoDetails(selectedDetails)
        }
    }
    
    // MARK: ViewModel Linking
    private func updateItems() {
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
    
    private func updateSortingTextFieldPlaceholder(_ newSortingName: String) {
        self.sortTextField.placeholder = newSortingName
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCurrencyListTVCell.reuseIdentifier, for: indexPath) as? HomeCurrencyListTVCell else {
            fatalError()
        }
        if let dailyData = self.homeViewModel[indexPath.item] {
            cell.setCellData(currencyInfo: dailyData)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.homeViewModel.didSelectDisplayitem(index: indexPath.item)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if self.sortTextField.isEditing {
            self.view.endEditing(true)
            return false
        }
        return true
    }
}

// MARK: - PickerView
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.homeViewModel.availableSortingOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row >= 0, row < homeViewModel.availableSortingOptions.count else { return nil }
        return self.homeViewModel.availableSortingOptions[row].sortingName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row >= 0, row < homeViewModel.availableSortingOptions.count else { return }
        self.homeViewModel.updateSorting(with: self.homeViewModel.availableSortingOptions[row])
    }
    
}

