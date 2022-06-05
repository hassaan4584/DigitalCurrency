//
//  HomeCurrencyListTVCell.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import UIKit

class HomeCurrencyListTVCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
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
    }

}
