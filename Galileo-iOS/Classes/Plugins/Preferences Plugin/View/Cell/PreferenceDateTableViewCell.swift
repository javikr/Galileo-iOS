//
//  PreferenceDateTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 16/11/2018.
//

import UIKit

class PreferenceDateTableViewCell: UITableViewCell
{
    weak var delegate: PreferenceTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var key: String?
    var viewModel: PreferenceDateViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            datePicker.date = viewModel?.value ?? Date()
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBAction func didChangeDate(_ sender: Any)
    {
        guard let key = key else { return }
        
        delegate?.didUpdate(value: datePicker.date, forKey: key)
    }
}
