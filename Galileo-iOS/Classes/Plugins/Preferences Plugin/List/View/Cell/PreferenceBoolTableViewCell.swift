//
//  PreferenceBoolTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceBoolTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapSwitch(sender: AnyObject) {
    }
}
