//
//  ConsoleLogGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

public final class ConsoleLogGalileoFactory
{
    public init() {}
    
    public func consoleLogGalileo() -> GalileoPlugin
    {
        let view = ConsoleLogGalileoViewController(nibName: String(describing: ConsoleLogGalileoViewController.self), bundle: Galileo.bundle)
        
        return ConsoleLogGalileoContainerViewController(rootViewController: view)
    }
}
