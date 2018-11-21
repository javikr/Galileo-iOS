//
//  ViewFlowTableViewCell.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 21/11/2018.
//

import UIKit

class ViewFlowTableViewCell: UITableViewCell
{
    @IBOutlet weak var viewBack: UIView! {
        didSet {
            viewBack.layer.cornerRadius = 8.0
            viewBack.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var screenshotImage: UIImageView!
    @IBOutlet weak var viewControllerName: UILabel! {
        didSet {
            viewControllerName.font = UIFont.boldSystemFont(ofSize: 18.0)
            viewControllerName.textColor = UIColor.black
        }
    }
    @IBOutlet weak var parametersList: UILabel! {
        didSet {
            parametersList.font = UIFont.systemFont(ofSize: 16.0)
            parametersList.textColor = UIColor.darkGray
        }
    }
    
    var viewModel: ViewFlowTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            screenshotImage.image = viewModel.image
            viewControllerName.text = viewModel.viewName
            parametersList.text = viewModel.viewParams
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool)
    {
        if highlighted {
            viewBack.backgroundColor = UIColor.lightGray
        } else {
            viewBack.backgroundColor = UIColor.white
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        backgroundColor = UIColor.groupTableViewBackground
    }
}
