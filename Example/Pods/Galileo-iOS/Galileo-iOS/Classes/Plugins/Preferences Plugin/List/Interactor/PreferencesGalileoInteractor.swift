//
//  PreferencesGalileoInteractor.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

class PreferencesGalileoInteractor
{
    weak var output: PreferencesGalileoOutput?
    let userDefaults = UserDefaults.standard
}

extension PreferencesGalileoInteractor: PreferencesGalileoInput
{
    func loadPreferences()
    {
        let prefs = userDefaults.dictionaryRepresentation()
        output?.didLoadedPreferences(preferences: prefs)
    }
}
