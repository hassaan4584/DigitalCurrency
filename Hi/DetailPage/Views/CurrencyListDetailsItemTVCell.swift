//
//  CurrencyListDetailsItemTVCell.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import UIKit

class CurrencyListDetailsItemTVCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    static let reuseIdentifier = "CurrencyListDetailsItemTVCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellData(currencyItem: CurrencyDetailsItem) {
        self.keyLabel.text = currencyItem.key
        self.valueLabel.text = currencyItem.value
    }

}
