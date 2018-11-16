//
//  PreferencesGalileoViewInterface.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

protocol PreferencesGalileoViewInterface: class
{
    func setupView()
    func set(tableViewDataSource: UITableViewDataSource)
    func set(tableViewDelegate: UITableViewDelegate)
    func refresh()
    func registerCells(cellsName: [String])
}
