//
//  SamplePluginViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit
import Galileo_iOS

class SamplePluginViewController: UIViewController
{
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
