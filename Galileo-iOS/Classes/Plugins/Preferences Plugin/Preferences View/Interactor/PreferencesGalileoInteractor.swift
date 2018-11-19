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
    
    private let userDefaultsSource: UserDefaults
    
    init(userDefaultsSource: UserDefaults)
    {
        self.userDefaultsSource = userDefaultsSource
    }
}

extension PreferencesGalileoInteractor: PreferencesGalileoInput
{
    func loadPreferences()
    {
        let prefs = userDefaultsSource.dictionaryRepresentation()
        output?.didLoadedPreferences(preferences: prefs)
    }
    
    func updatePreference(withKey key: String, newValue: Any)
    {
        userDefaultsSource.set(newValue, forKey: key)
        output?.updatedPreference(withKey: key, updatedValue: newValue)
    }
    
    func deletePreference(withKey key: String)
    {
        userDefaultsSource.removeObject(forKey: key)
        output?.deletedPreference(withKey: key)
    }
}
