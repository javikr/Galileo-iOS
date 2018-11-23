//
//  WormholyGalileoPluginViewControllerFactory.swift
//  Alamofire
//
//  Created by Javier Aznar de los Rios on 20/11/2018.
//

import Foundation
import Wormholy

public final class WormholyGalileoPluginViewControllerFactory
{
    public init() {}
    
    public func wormholyGalileoPlugin() -> GalileoPlugin
    {
        let wormholy = Wormholy.wormholyFlow!.children.first!

        return WormholyGalileoPluginViewController(rootViewController: wormholy)
    }
}
