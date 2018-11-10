//
//  GalileoPlugin.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

/**
 Protocol that must be implemented in a Galileo plugin
 
 */
public protocol GalileoPlugin where Self: UIViewController
{
    var pluginName: String { get }
    var pluginIcon: UIImage? { get }
    
    func setupPlugin()
}

public extension GalileoPlugin
{
    func setupPlugin() {}
}
