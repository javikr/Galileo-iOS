//
//  MainViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class GalileoMainViewController: UITabBarController
{    
    init(plugins: [GalileoPlugin])
    {
        let defaultIcon = UIImage(named: "103-doubt", in: Galileo.bundle, compatibleWith: nil)
        let views: [UIViewController] = plugins.map { (plugin) in
            let view = plugin as! UIViewController
            view.tabBarItem = UITabBarItem(title: plugin.pluginName, image: plugin.pluginIcon ?? defaultIcon, selectedImage: nil)
            return view
        }

        print("asdsadasd")
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = views
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Galileo"
    }
}
