//
//  UvCell.swift
//  AdvisorApp
//
//  Created by Clément Garbay on 03/06/2016.
//

import UIKit

class UvCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var prerequisitesLabel: UILabel!
    @IBOutlet var corequisitesLabel: UILabel!
    @IBOutlet var selectionLabel: UILabel!
    @IBOutlet var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
