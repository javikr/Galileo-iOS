//
//  PreferenceIntegerTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 15/11/2018.
//

import UIKit

class PreferenceIntegerTableViewCell: UITableViewCell
{
    weak var delegate: PreferenceTableViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.font = UIFont.systemFont(ofSize: 18.0)
            valueLabel.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var stepper: UIStepper!
    
    var key: String?
    var viewModel: PreferenceIntegerViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            valueLabel.text = String(viewModel?.value ?? 0)
            stepper.value = Double(viewModel?.value ?? 0)
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    
        selectionStyle = .none
    }

    @IBAction func didTapStepper(_ sender: Any)
    {
        guard let key = key else { return }
        
        valueLabel.text = String(Int(stepper.value))
        
        delegate?.didUpdate(value: Int(stepper.value), forKey: key)
    }
}
