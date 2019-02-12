//
//  ConsoleLogGalileoContainerViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class ConsoleLogGalileoContainerViewController: UINavigationController
{
    var enabled: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}

extension ConsoleLogGalileoContainerViewController: GalileoPlugin
{
    var pluginName: String {
        return "Console"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "200-terminal", in: Galileo.bundle, compatibleWith: nil)
    }
}
