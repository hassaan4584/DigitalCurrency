//
//  HomeViewController.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import UIKit

class HomeViewController: UIViewController {

    static func createListViewController() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeViewController") { aCoder in
            return HomeViewController(someData: "SomeDataString", coder: aCoder)
        }
        return vc
    }
    
    init?(someData: String, coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DotsLoadingIndicator.indicator.show(inView: self.view)
    }


}

