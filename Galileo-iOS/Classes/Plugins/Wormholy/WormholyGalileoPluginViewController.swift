//
//  WormholyGalileoPluginViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit
import Wormholy

class WormholyGalileoPluginViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        addWormholyView()
    }
    
    private func addWormholyView()
    {
        guard let wormholy = Wormholy.wormholyFlow else { return }

        addChild(wormholy)
        view.addSubview(wormholy.view)
        wormholy.didMove(toParent: self)
    }
}

extension WormholyGalileoPluginViewController: GalileoPlugin
{
    var pluginName: String {
        return "Wormholy"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "025-asteroid", in: Galileo.bundle, compatibleWith: nil)
    }
    
    func setupPlugin()
    {
        Wormholy.shakeEnabled = false
    }
}
