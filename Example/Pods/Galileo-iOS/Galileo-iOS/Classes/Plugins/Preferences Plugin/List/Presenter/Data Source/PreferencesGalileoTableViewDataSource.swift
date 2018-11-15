//
//  PreferencesGalileoTableViewDataSource.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesGalileoTableViewDataSource: NSObject
{
    var preferences: [String : Any]
    weak var delegate: PreferencesGalileoTableViewDataSourceDelegate?
    
    private var orderedPreferencesKeys: [String] {
        return Array(preferences.keys).sorted()
    }
    
    init(preferences: [String : Any], delegate: PreferencesGalileoTableViewDataSourceDelegate?)
    {
        self.preferences = preferences
        self.delegate = delegate
    }
    
    func update(preferences: [String : Any])
    {
        self.preferences = preferences
    }
}

extension PreferencesGalileoTableViewDataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return preferences.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let key = orderedPreferencesKeys[indexPath.row]
        let value = preferences[key]!
        
        let cell: UITableViewCell
        if let theCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = theCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = (value as AnyObject).debugDescription
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension PreferencesGalileoTableViewDataSource: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let key = orderedPreferencesKeys[indexPath.row]
        delegate?.didSelectPreference(withKey: key)
    }
}
