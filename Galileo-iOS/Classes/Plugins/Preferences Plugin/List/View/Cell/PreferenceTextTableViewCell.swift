//
//  PreferenceTextTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceTextTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var valueTextField: UITextField! {
        didSet {
            valueTextField.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PreferenceTextTableViewCell: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // TODO
    }
}
