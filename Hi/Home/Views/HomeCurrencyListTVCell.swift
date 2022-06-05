//
//  HomeCurrencyListTVCell.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import UIKit

class HomeCurrencyListTVCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var marketCapTitleLabel: UILabel!
    @IBOutlet weak var marketCapValueLabel: UILabel!
    
    static let reuseIdentifier = "HomeCurrencyListTVCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(currencyInfo: TimeSeriesDigitalCurrencyDaily) {
        self.dateLabel.text = currencyInfo.dateStr
        let key = currencyInfo.marketCapKey?.split(separator: " ").dropFirst().joined(separator: " ")
        self.marketCapTitleLabel.text = key
        self.marketCapValueLabel.text = "\(currencyInfo.marketCapValue)"
    }

}
