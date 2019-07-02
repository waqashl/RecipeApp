//
//  RecipeTableViewCell.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 02/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageV.kf.indicatorType = .activity
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
