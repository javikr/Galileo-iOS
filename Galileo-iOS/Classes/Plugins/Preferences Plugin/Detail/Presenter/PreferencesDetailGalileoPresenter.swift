//
//  PreferencesDetailGalileoPresenter.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

class PreferencesDetailGalileoPresenter
{
    weak var view: PreferencesDetailGalileoViewInterface?
    var interactor: PreferencesDetailGalileoInput!
    var routing: PreferencesDetailGalileoRoutingInterface!
}

extension PreferencesDetailGalileoPresenter: PreferencesDetailGalileoPresenterInterface
{
    func viewLoaded()
    {
        interactor.loadPreferenceData()
    }
    
    func didTapSave(value: String)
    {
        interactor.update(value: value)
    }
    
    func didTapDelete()
    {
        interactor.delete()
    }
}

extension PreferencesDetailGalileoPresenter: PreferencesDetailGalileoOutput
{
    func loadedPreferenceData(preferenceData: PreferenceData)
    {
        let viewModel = PreferencesDetailGalileoViewModel(key: preferenceData.key, value: preferenceData.value)
        view?.configureView(withViewModel: viewModel)
    }
    
    func didUpdatePreference()
    {
        routing.goBack()
    }
    
    func didDeletePreference()
    {
        routing.goBack()
    }
}
