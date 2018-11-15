//
//  PreferenceIntegerTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceIntegerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var viewModel: PreferenceIntegerViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            valueLabel.text = String(viewModel?.value ?? 0)
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapStepper(_ sender: Any)
    {
        
    }
}
