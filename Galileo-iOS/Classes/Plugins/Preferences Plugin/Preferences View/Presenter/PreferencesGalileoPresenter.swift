//
//  PreferencesGalileoPresenter.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

class PreferencesGalileoPresenter
{
    weak var view: PreferencesGalileoViewInterface?
    var interactor: PreferencesGalileoInput!
    var dataSource: PreferencesGalileoTableViewDataSource!
}

extension PreferencesGalileoPresenter: PreferencesGalileoPresenterInterface
{
    func viewLoaded()
    {
        view?.setupView()
        view?.registerCells(cellsName: [
            String(describing: PreferenceBoolTableViewCell.self),
            String(describing: PreferenceIntegerTableViewCell.self),
            String(describing: PreferenceTextTableViewCell.self),
            String(describing: PreferenceDateTableViewCell.self)
            ])
        view?.set(tableViewDataSource: dataSource)
        view?.set(tableViewDelegate: dataSource)
    }
    
    func viewWillAppear()
    {
        interactor.loadPreferences()
    }
}

extension PreferencesGalileoPresenter: PreferencesGalileoOutput
{
    func didLoadedPreferences(preferences: [String: Any])
    {
        let viewTypes: [PreferenceViewType] = preferences.keys.sorted().compactMap { (key) in
            guard let value = preferences[key] else { return nil }
            
            return PreferenceViewTypeMapper().transform(fromKey: key, value: value)
        }
        
        dataSource.update(preferences: viewTypes)
        view?.refresh()
    }
    
    func updatedPreference(withKey key: String, updatedValue: Any)
    {
        let preferenceViewType = PreferenceViewTypeMapper().transform(fromKey: key, value: updatedValue)
        dataSource.update(preference: preferenceViewType)
    }
    
    func deletedPreference(withKey key: String)
    {
        // TODO: feedback
    }
}

extension PreferencesGalileoPresenter: PreferencesGalileoTableViewDataSourceDelegate
{
    func didUpdatePreference(withKey key: String, newValue: Any)
    {
        interactor.updatePreference(withKey: key, newValue: newValue)
    }
    
    func didDeletePreference(withKey key: String)
    {
        interactor.deletePreference(withKey: key)
    }
    
    func didToggleView(atIndex index: Int)
    {
        view?.refreshCell(atIndex: index)
    }
}
