//
//  TripCategorySettingViewCell.swift
//  projectTrip
//
//  Created by Friday on 2017. 1. 6..
//  Copyright © 2017년 SwiftTive. All rights reserved.
//

import UIKit

class TripCategorySettingViewCell: UITableViewCell {

    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
