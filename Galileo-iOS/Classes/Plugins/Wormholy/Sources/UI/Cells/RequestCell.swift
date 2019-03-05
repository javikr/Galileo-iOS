//
//  RequestCell.swift
//  Wormholy-iOS
//
//  Created by Paolo Musolino on 13/04/18.
//  Copyright © 2018 Wormholy. All rights reserved.
//

import UIKit

class RequestCell: UICollectionViewCell {
    
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel! {
        didSet {
            codeLabel.layer.borderWidth = 1.0
            codeLabel.layer.cornerRadius = 6.0
        }
    }
    @IBOutlet weak var urlLabel: UILabel! {
        didSet {
            urlLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var durationLabel: UILabel!
    
    func populate(request: RequestModel?){
        guard request != nil else {
            return
        }
        
        methodLabel.text = request?.method.uppercased()
        codeLabel.isHidden = request?.code == 0 ? true : false
        codeLabel.text = request?.code != nil ? String(request!.code) : "-"
        if let code = request?.code{
            var color: UIColor = Colors.HTTPCode.Generic
            switch code {
            case 200..<300:
                color = Colors.HTTPCode.Success
            case 300..<400:
                color = Colors.HTTPCode.Redirect
            case 400..<500:
                color = Colors.HTTPCode.ClientError
            case 500..<600:
                color = Colors.HTTPCode.ServerError
            default:
                color = Colors.HTTPCode.Generic
            }
            codeLabel.layer.borderColor = color.cgColor
            codeLabel.textColor = color
        }
        else{
            codeLabel.layer.borderColor = Colors.HTTPCode.Generic.cgColor
            codeLabel.textColor = Colors.HTTPCode.Generic
        }
        urlLabel.text = request?.url
        durationLabel.text = request?.date.stringWithFormat(dateFormat: "hh:mm:ss")
    }
}
