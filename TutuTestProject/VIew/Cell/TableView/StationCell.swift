//
//  StationTableViewCell.swift
//  TutuTestProject
//
//  Created by Alexey Danilov on 19/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class StationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
