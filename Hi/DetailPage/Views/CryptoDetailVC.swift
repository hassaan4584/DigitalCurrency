//
//  CryptoDetailVC.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import UIKit

class CryptoDetailVC: UIViewController {

    @IBOutlet weak var digitalCurrencyNameLabel: UILabel!
    
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
    }
    
}
