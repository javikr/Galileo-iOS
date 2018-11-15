//
//  PreferencesDetailGalileoFactory.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesDetailGalileoFactory
{
    func PreferencesDetailGalileo(preferenceKey: String) -> UIViewController
    {
        let presenter = PreferencesDetailGalileoPresenter()
        let view = PreferencesDetailGalileoViewController(nibName: "PreferencesDetailGalileoViewController", bundle: Galileo.bundle)
        let interactor = PreferencesDetailGalileoInteractor(preferenceKey: preferenceKey)
        let routing = PreferencesDetailGalileoRouting(presentedView: view)
        view.eventHandler = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.routing = routing
        interactor.output = presenter
        
        return view
    }
}
