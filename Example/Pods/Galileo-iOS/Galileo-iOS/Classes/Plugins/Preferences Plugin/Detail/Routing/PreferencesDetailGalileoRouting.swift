//
//  PreferencesDetailGalileoRouting.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesDetailGalileoRouting
{
    var presentedView: UIViewController
    
    init(presentedView: UIViewController)
    {
        self.presentedView = presentedView
    }
}

extension PreferencesDetailGalileoRouting: PreferencesDetailGalileoRoutingInterface
{
    func goBack()
    {
        presentedView.navigationController?.popViewController(animated: true)
    }
}
