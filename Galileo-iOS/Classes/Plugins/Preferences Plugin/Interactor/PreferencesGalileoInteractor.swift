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
    
    func updatePreference(withKey key: String, newValue: Any)
    {
        userDefaults.set(newValue, forKey: key)
        output?.updatedPreference(withKey: key, updatedValue: newValue)
    }
    
    func deletePreference(withKey key: String)
    {
        userDefaults.removeObject(forKey: key)
        output?.deletedPreference(withKey: key)
    }
}
