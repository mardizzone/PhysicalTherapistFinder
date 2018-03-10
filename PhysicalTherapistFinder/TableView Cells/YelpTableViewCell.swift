//
//  YelpTableViewCell.swift
//  PhysicalTherapistFinder
//
//  Created by Michael Ardizzone on 3/8/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class YelpTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
