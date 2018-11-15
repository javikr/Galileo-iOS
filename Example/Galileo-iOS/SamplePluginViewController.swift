//
//  SamplePluginViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

#if DEBUG
import Galileo_iOS

class SamplePluginViewController: UIViewController
{
    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            if #available(iOS 11.0, *) {
                txtEmail.textContentType = .username
            } else {
                // Fallback on earlier versions
            }
        }
    }
    @IBOutlet weak var txtPassword: UITextField! {
        didSet {
            txtPassword.isSecureTextEntry = true
            
            if #available(iOS 12.0, *) {
                txtPassword.textContentType = .newPassword
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }
}

extension SamplePluginViewController: GalileoPlugin
{
    public var pluginName: String {
        return "sample"
    }
    
    public var pluginIcon: UIImage? {
        return nil
    }
}

#endif
