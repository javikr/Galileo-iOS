//
//  PreferencesGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoFactory
{
    func preferencesGalileo() -> GalileoPlugin
    {
        let presenter = PreferencesGalileoPresenter()
        let interactor = PreferencesGalileoInteractor()
        let view = PreferencesGalileoViewController(nibName: String(describing: PreferencesGalileoViewController.self), bundle: Galileo.bundle)
        view.eventHandler = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.dataSource = PreferencesGalileoTableViewDataSource(preferences: [], delegate: presenter)
        
        return PreferencesGalileoContainerViewController(rootViewController: view)
    }
}
