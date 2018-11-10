//
//  PreferencesDetailGalileoIO.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

protocol PreferencesDetailGalileoInput
{
    func loadPreferenceData()
    func update(value: Any)
    func delete()
}

protocol PreferencesDetailGalileoOutput: class
{
    func loadedPreferenceData(preferenceData: PreferenceData)
    func didUpdatePreference()
    func didDeletePreference()
}

