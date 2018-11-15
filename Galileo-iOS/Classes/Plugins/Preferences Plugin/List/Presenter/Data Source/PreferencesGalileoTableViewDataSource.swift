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
    var preferences: [PreferenceViewModel]
    weak var delegate: PreferencesGalileoTableViewDataSourceDelegate?
    
    init(preferences: [PreferenceViewModel], delegate: PreferencesGalileoTableViewDataSourceDelegate?)
    {
        self.preferences = preferences
        self.delegate = delegate
    }
    
    func update(preferences: [PreferenceViewModel])
    {
        self.preferences = preferences
    }
}

extension PreferencesGalileoTableViewDataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return preferences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return UITableViewCell()
//        let preference = preferences[indexPath.row]
//        let value = preference.
//
//        let cell: UITableViewCell
//        if let theCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
//            cell = theCell
//        } else {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        }
//        cell.textLabel?.text = key
//        cell.detailTextLabel?.text = (value as AnyObject).debugDescription
//        cell.accessoryType = .disclosureIndicator
//
//        return cell
    }
}

extension PreferencesGalileoTableViewDataSource: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let key = orderedPreferencesKeys[indexPath.row]
//        delegate?.didSelectPreference(withKey: key)
    }
}
