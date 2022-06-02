//
//  DetailsNavigationCoordinator.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import Foundation
import UIKit

protocol DetailsNavigationCoordinator {
    func navigateToCryptoDetailsVC(viewModel: CryptoDetailViewModelProtocol)
}

extension DetailsNavigationCoordinator where Self: UIViewController {
    func navigateToCryptoDetailsVC(viewModel: CryptoDetailViewModelProtocol) {
        let detailsVC = CryptoDetailVC.createCryptoDetailsScreen(viewModel: viewModel)
        
        if let navController = self.navigationController {
            navController.pushViewController(detailsVC, animated: true)
        } else {
            self.present(detailsVC , animated: true, completion: nil)
        }
    }
}
