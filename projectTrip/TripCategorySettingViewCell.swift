//
//  TripCategorySettingViewCell.swift
//  projectTrip
//
//  Created by Friday on 2017. 1. 15..
//  Copyright © 2017년 SwiftTive. All rights reserved.
//

import UIKit

class TripCategorySettingViewCell: UITableViewCell {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
