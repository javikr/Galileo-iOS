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
//        dataSource.update(preferences: preferences)
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
