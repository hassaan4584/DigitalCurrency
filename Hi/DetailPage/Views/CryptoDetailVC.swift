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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
