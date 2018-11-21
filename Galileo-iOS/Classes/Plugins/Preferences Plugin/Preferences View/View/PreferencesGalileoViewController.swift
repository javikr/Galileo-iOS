//
//  PreferencesGalileoViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoViewController: UITableViewController
{
    var eventHandler: PreferencesGalileoPresenterInterface!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        eventHandler.viewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        eventHandler.viewWillAppear()
    }
}

extension PreferencesGalileoViewController: PreferencesGalileoViewInterface
{
    func setupView()
    {
        navigationItem.title = "Preferences Manager"
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func set(tableViewDataSource: UITableViewDataSource)
    {
        tableView.dataSource = tableViewDataSource
    }
    
    func set(tableViewDelegate: UITableViewDelegate)
    {
        tableView.delegate = tableViewDelegate
    }
    
    func refresh()
    {
        tableView.reloadData()
    }
    
    func registerCells(cellsName: [String])
    {
        for cellName in cellsName {
            let nib = UINib(nibName: cellName, bundle: Galileo.bundle)
            tableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
    
    func refreshCell(atIndex index: Int)
    {
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
