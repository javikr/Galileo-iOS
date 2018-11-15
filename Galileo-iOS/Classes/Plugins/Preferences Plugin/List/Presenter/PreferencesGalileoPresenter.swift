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
    var routing: PreferencesGalileoRoutingInterface!
    var dataSource: PreferencesGalileoTableViewDataSource!
}

extension PreferencesGalileoPresenter: PreferencesGalileoPresenterInterface
{
    func viewLoaded()
    {
        view?.setupView()
        view?.set(tableViewDataSource: dataSource)
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
        let viewTypes: [PreferenceViewType] = preferences.keys.compactMap { (key) in
            let value = preferences[key]
            switch value {
            case is Bool: return PreferenceViewType.boolean(key: key, viewModel: PreferenceBoolViewModel(title: key, value: value as! Bool))
            case is Int: return PreferenceViewType.integer(key: key, viewModel: PreferenceIntegerViewModel(title: key, value: value as! Int))
            case is String: return PreferenceViewType.text(key: key, viewModel: PreferenceTextViewModel(title: key, value: value as! String))
            default: return PreferenceViewType.text(key: key, viewModel: PreferenceTextViewModel(title: key, value: value.debugDescription))
            }
        }
        
        dataSource.update(preferences: viewTypes)
        view?.refresh()
    }
}

extension PreferencesGalileoPresenter: PreferencesGalileoTableViewDataSourceDelegate
{
    func didSelectPreference(withKey key: String)
    {
        routing.launchPreferenceDetail(key: key)
    }
}
