//
//  VendorTableViewCell.swift
//  Mars
//
//  Created by Arpit Lokwani on 02/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

protocol VendorCheckBoxDelegate {
    func didPressedRadioButton(button:UIButton)
}

class VendorTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var VendorNameLabel: UILabel!
    @IBAction func checkBtnAction(_ sender: Any) {
        print("radiobuttonPRessed")
        delegate?.didPressedRadioButton(button: sender as! UIButton)
    }
    @IBOutlet weak var flavorHeaderLabel: UILabel!
    
    @IBOutlet weak var checkbuttonAction: UIButton!
    @IBOutlet weak var flavorDataLabel: UILabel!
    @IBOutlet weak var legacyDataLabel: UILabel!
    @IBOutlet weak var countryDataLabel: UILabel!
    @IBOutlet weak var vendorImageLabel: UILabel!
    var delegate:VendorCheckBoxDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vendorImageLabel.layer.cornerRadius = 19
        self.vendorImageLabel.layer.masksToBounds = true;
        self.amountLabel.layer.cornerRadius = 10
        self.amountLabel.layer.masksToBounds = true;
        
        self.vendorImageLabel.backgroundColor = UIColor.randomColor(randomAlpha: false)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
