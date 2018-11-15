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
    
    var viewModel: PreferenceTextViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            valueTextField.text = viewModel?.value ?? ""
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

extension PreferenceTextTableViewCell: UITextFieldDelegate
{
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        // TODO
    }
}
