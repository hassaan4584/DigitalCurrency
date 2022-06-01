//
//  HomeCurrencyListTVCell.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import UIKit

class HomeCurrencyListTVCell: UITableViewCell {

    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
