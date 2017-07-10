//
//  PuppyCell.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/9/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import UIKit

class PuppyCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
