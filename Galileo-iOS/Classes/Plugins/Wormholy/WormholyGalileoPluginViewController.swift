//
//  WormholyGalileoPluginViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

final class WormholyGalileoPluginViewController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        children.first?.navigationItem.rightBarButtonItems = nil
    }
}

extension WormholyGalileoPluginViewController: GalileoPlugin
{
    public var pluginName: String {
        return "Wormholy"
    }
    
    public var pluginIcon: UIImage? {
        return UIImage(named: "025-asteroid", in: Galileo.bundle, compatibleWith: nil)
    }
    
    public func setupPlugin()
    {
        Wormholy.enable(true, sessionConfiguration: URLSessionConfiguration.default)
        Wormholy.enable(true, sessionConfiguration: URLSessionConfiguration.ephemeral)
    }
}
