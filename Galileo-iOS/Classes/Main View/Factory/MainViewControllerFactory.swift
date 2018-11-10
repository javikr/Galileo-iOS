//
//  MainViewControllerFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class MainViewControllerFactory
{
    func mainViewController(plugins: [GalileoPlugin]) -> UIViewController
    {
        return GalileoMainViewController(plugins: plugins)
    }
}
