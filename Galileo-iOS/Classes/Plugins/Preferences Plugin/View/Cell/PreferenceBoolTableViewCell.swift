//
//  PreferenceBoolTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceBoolTableViewCell: UITableViewCell
{
    weak var delegate: PreferenceTableViewCellDelegate?
    
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet var valueSwitch: UISwitch!
    
    var key: String?
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
        guard let key = key else { return }
        
        delegate?.didUpdate(value: valueSwitch.isOn, forKey: key)
    }
}
