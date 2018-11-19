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
    var preferences: [PreferenceViewType]
    weak var delegate: PreferencesGalileoTableViewDataSourceDelegate?
    
    init(preferences: [PreferenceViewType], delegate: PreferencesGalileoTableViewDataSourceDelegate?)
    {
        self.preferences = preferences
        self.delegate = delegate
    }
    
    func update(preferences: [PreferenceViewType])
    {
        self.preferences = preferences
    }
    
    func update(preference: PreferenceViewType)
    {
        guard let preferenceIndex = preferences.firstIndex(where: { preference.key == $0.key }) else { return }
        
        preferences[preferenceIndex] = preference
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
        let preference = preferences[indexPath.row]
        
        switch preference {
        case let .boolean(key, viewModel): return booleanCell(tableView: tableView, viewModel: viewModel, key: key)
        case let .text(key, viewModel): return textCell(tableView: tableView, viewModel: viewModel, key: key)
        case let .integer(key, viewModel): return integerCell(tableView: tableView, viewModel: viewModel, key: key)
        case let .date(key, viewModel): return dateCell(tableView: tableView, viewModel: viewModel, key: key)
        case let .other(key, viewModel): return textCell(tableView: tableView, viewModel: viewModel, key: key)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        guard editingStyle == .delete else { return }
        
        let preferenceKey = preferences[indexPath.row].key
        
        delegate?.didDeletePreference(withKey: preferenceKey)
        
        preferences.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func booleanCell(tableView: UITableView, viewModel: PreferenceBoolViewModel, key: String) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceBoolTableViewCell.self)) as? PreferenceBoolTableViewCell
            
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: PreferenceBoolTableViewCell.self), owner: nil, options: nil)?.first as? PreferenceBoolTableViewCell
        }
        
        cell?.viewModel = viewModel
        cell?.key = key
        cell?.delegate = self
        
        return cell!
    }
    
    private func textCell(tableView: UITableView, viewModel: PreferenceTextViewModel, key: String) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceTextTableViewCell.self)) as? PreferenceTextTableViewCell
        
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: PreferenceTextTableViewCell.self), owner: self, options: nil)?.first as? PreferenceTextTableViewCell
        }
        
        cell?.viewModel = viewModel
        cell?.key = key
        cell?.delegate = self
        
        return cell!
    }
    
    private func integerCell(tableView: UITableView, viewModel: PreferenceIntegerViewModel, key: String) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceIntegerTableViewCell.self)) as? PreferenceIntegerTableViewCell
        
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: PreferenceIntegerTableViewCell.self), owner: self, options: nil)?.first as? PreferenceIntegerTableViewCell
        }
        
        cell?.viewModel = viewModel
        cell?.key = key
        cell?.delegate = self
        
        return cell!
    }
    
    private func dateCell(tableView: UITableView, viewModel: PreferenceDateViewModel, key: String) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceDateTableViewCell.self)) as? PreferenceDateTableViewCell
        
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: PreferenceDateTableViewCell.self), owner: self, options: nil)?.first as? PreferenceDateTableViewCell
        }
        
        cell?.viewModel = viewModel
        cell?.key = key
        cell?.delegate = self
        
        return cell!
    }
}

extension PreferencesGalileoTableViewDataSource: UITableViewDelegate
{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        scrollView.endEditing(true)
    }
}

extension PreferencesGalileoTableViewDataSource: PreferenceTableViewCellDelegate
{
    func didUpdate(value: Any, forKey key: String)
    {        
        delegate?.didUpdatePreference(withKey: key, newValue: value)
    }
}

extension PreferencesGalileoTableViewDataSource: PreferenceDateTableViewCellDelegate
{
    func didToggleDisplayDate(hide: Bool, key: String)
    {
        guard let index = preferences.firstIndex(where: { key == $0.key }) else { return }
        
        guard case let PreferenceViewType.date(_, viewModel) = preferences[index] else { return }
        
        let newViewType = PreferenceViewTypeMapper().transform(fromKey: key, value: viewModel.value, isViewCollapsed: hide)
        update(preference: newViewType)
        
        delegate?.didToggleView(atIndex: index)
    }
}
