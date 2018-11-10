//
//  ConsoleLogGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

class ConsoleLogGalileoFactory
{
    func consoleLogGalileo() -> GalileoPlugin
    {
        let view = ConsoleLogGalileoViewController(nibName: "ConsoleLogGalileoViewController", bundle: Galileo.bundle)
        
        return ConsoleLogGalileoContainerViewController(rootViewController: view)
    }
}
