//
//  PreferencesDetailGalileoInteractor.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

class PreferencesDetailGalileoInteractor
{
    weak var output: PreferencesDetailGalileoOutput?
    
    var userDefaults = UserDefaults.standard
    private let preferenceKey: String
    
    init(preferenceKey: String)
    {
        self.preferenceKey = preferenceKey
    }
}

extension PreferencesDetailGalileoInteractor: PreferencesDetailGalileoInput
{
    func loadPreferenceData()
    {
        guard let value = userDefaults.value(forKey: preferenceKey), let preferenceValue = (value as AnyObject).debugDescription else { return }
        
        let preferenceData = PreferenceData(key: preferenceKey, value: preferenceValue)
        output?.loadedPreferenceData(preferenceData: preferenceData)
    }
    
    func update(value: Any)
    {
        userDefaults.set(value, forKey: preferenceKey)
        output?.didUpdatePreference()
    }
    
    func delete()
    {
        userDefaults.removeObject(forKey: preferenceKey)
        output?.didDeletePreference()
    }
}
