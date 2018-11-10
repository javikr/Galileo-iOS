//
//  PreferencesGalileoViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoViewController: UIViewController
{
    var eventHandler: PreferencesGalileoPresenterInterface!
    
    @IBOutlet weak var tableView: UITableView!
    
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
}
