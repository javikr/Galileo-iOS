//
//  ViewFlowDetailTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 21/11/2018.
//

import UIKit

class ViewFlowDetailTableViewCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel! {
        didSet {
            title.font = UIFont.boldSystemFont(ofSize: 18.0)
        }
    }
    @IBOutlet weak var subtitle: UILabel! {
        didSet {
            subtitle.font = UIFont.systemFont(ofSize: 16.0)
        }
    }
    
    var propertyTitle: String? {
        didSet {
            title.text = propertyTitle
        }
    }
    var propertyValue: String? {
        didSet {
            subtitle.text = propertyValue
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}
