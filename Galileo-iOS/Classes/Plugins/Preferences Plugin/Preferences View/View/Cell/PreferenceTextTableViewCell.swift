//
//  PreferenceTextTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceTextTableViewCell: UITableViewCell
{
    weak var delegate: PreferenceTableViewCellDelegate?
    
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet var valueTextField: UITextField! {
        didSet {
            valueTextField.delegate = self
            valueTextField.font = UIFont.systemFont(ofSize: 16.0)
            valueTextField.textColor = UIColor.darkGray
        }
    }
    
    var key: String?
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
        guard let key = key else { return }
        
        delegate?.didUpdate(value: textField.text ?? "", forKey: key)
    }
}
