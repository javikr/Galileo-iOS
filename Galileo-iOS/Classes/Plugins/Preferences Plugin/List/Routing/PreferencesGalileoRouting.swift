//
//  PreferencesGalileoRouting.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoRouting
{
    private let presentedView: UIViewController
    
    init(presentedView: UIViewController)
    {
        self.presentedView = presentedView
    }
}

extension PreferencesGalileoRouting: PreferencesGalileoRoutingInterface
{
    func launchPreferenceDetail(key: String)
    {
       let detailVC = PreferencesDetailGalileoFactory().PreferencesDetailGalileo(preferenceKey: key)
        presentedView.navigationController?.pushViewController(detailVC, animated: true)
    }
}
