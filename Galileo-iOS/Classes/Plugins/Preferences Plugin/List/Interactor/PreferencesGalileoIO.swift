//
//  PreferencesGalileoIO.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

protocol PreferencesGalileoInput
{
    func loadPreferences()
}

protocol PreferencesGalileoOutput: class
{
    func didLoadedPreferences(preferences: [String: Any])
}
