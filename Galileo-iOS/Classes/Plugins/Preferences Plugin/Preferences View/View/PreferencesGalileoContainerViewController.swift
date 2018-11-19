//
//  PreferencesGalileoContainerView.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoContainerViewController: UINavigationController {}

extension PreferencesGalileoContainerViewController: GalileoPlugin
{
    var pluginName: String {
        return "User Defaults"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "101-data", in: Galileo.bundle, compatibleWith: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}
