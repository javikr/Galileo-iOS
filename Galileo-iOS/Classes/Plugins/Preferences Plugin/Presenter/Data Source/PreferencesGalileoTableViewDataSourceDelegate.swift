//
//  PreferencesGalileoTableViewDataSourceDelegate.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

protocol PreferencesGalileoTableViewDataSourceDelegate: class
{
    func didUpdatePreference(withKey key: String, newValue: Any)
    func didDeletePreference(withKey: String)
}
