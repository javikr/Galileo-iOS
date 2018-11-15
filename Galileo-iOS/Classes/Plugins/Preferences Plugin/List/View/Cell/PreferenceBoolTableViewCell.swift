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
    
    var viewModel: PreferenceBoolViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            valueSwitch.isOn = viewModel?.value ?? false
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBAction func didTapSwitch(sender: AnyObject)
    {
    }
}
