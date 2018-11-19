//
//  PreferencesGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

public final class PreferencesGalileoFactory
{
    public init() {}
    
    public func preferencesGalileo(userDefaultsSources: [UserDefaults] = [UserDefaults.standard]) -> GalileoPlugin
    {
        let view = PreferencesGalileoSourcesTableViewController(sources: userDefaultsSources)
        
        return PreferencesGalileoContainerViewController(rootViewController: view)
    }
}
