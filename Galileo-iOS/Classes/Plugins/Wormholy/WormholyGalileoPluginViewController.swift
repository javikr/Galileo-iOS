//
//  WormholyGalileoPluginViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit
import Wormholy

public final class WormholyGalileoPluginViewController: UIViewController
{
    override public func viewDidLoad()
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
        
        NSLayoutConstraint.activate([
            wormholy.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            wormholy.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            wormholy.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            wormholy.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
            ])
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
        Wormholy.shakeEnabled = false
    }
}
