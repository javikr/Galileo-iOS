//
//  PreferencesDetailGalileoPresenterInterface.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import Foundation

protocol PreferencesDetailGalileoPresenterInterface
{
    func viewLoaded()
    func didTapSave(value: String)
    func didTapDelete()
}
