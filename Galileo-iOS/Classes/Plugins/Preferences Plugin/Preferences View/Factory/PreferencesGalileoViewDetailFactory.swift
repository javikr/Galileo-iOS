//
//  PreferencesGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoViewDetailFactory
{
    func preferencesGalileoView(userDefaultsSource: UserDefaults) -> UIViewController
    {
        let presenter = PreferencesGalileoPresenter()
        let interactor = PreferencesGalileoInteractor(userDefaultsSource: userDefaultsSource)
        let view = PreferencesGalileoViewController(nibName: String(describing: PreferencesGalileoViewController.self), bundle: Galileo.bundle)
        view.eventHandler = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.dataSource = PreferencesGalileoTableViewDataSource(preferences: [], delegate: presenter)
        
        return view
    }
}
