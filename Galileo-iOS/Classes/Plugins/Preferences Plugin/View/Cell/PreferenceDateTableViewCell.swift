//
//  PreferenceDateTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 16/11/2018.
//

import UIKit

class PreferenceDateTableViewCell: UITableViewCell
{
    weak var delegate: PreferenceDateTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            titleLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var key: String?
    var viewModel: PreferenceDateViewModel? {
        didSet {
            let date = viewModel?.value ?? Date()
            
            titleLabel.text = viewModel?.title
            datePicker.date = date
            datePicker.isHidden = viewModel?.isViewCollapsed ?? false
            showHideButton.setTitle(dateFormatter.string(from: date), for: .normal)
            showHideButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    @IBAction func didChangeDate(_ sender: Any)
    {
        guard let key = key else { return }
        
        showHideButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        
        delegate?.didUpdate(value: datePicker.date, forKey: key)
    }
    
    @IBAction func didTapShowHideButton(_ sender: Any)
    {
        guard let key = key else { return }
        
        delegate?.didToggleDisplayDate(hide: !datePicker.isHidden, key: key)
    }
}
