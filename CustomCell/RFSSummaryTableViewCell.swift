//
//  RFSSummaryTableViewCell.swift
//  Mars
//
//  Created by Arpit Lokwani on 04/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class RFSSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var dataNameLabel: UILabel!
    @IBOutlet weak var contentNameLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViews.layer.cornerRadius = 30
        imageLabel.layer.cornerRadius = 30
        imageLabel.layer.masksToBounds = true
        

         self.imageLabel.backgroundColor = UIColor.randomColor(randomAlpha: false)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
