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
        case .boolean(_, let viewModel): return booleanCell(tableView: tableView, viewModel: viewModel)
        case .text(_, let viewModel): return textCell(tableView: tableView, viewModel: viewModel)
        case .integer(_, let viewModel): return integerCell(tableView: tableView, viewModel: viewModel)
        case .other(_, let viewModel): return textCell(tableView: tableView, viewModel: viewModel)
        }
    }
    
    private func booleanCell(tableView: UITableView, viewModel: PreferenceBoolViewModel) -> UITableViewCell
    {
        let cell: PreferenceBoolTableViewCell
        if let theCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceBoolTableViewCell.self)) as? PreferenceBoolTableViewCell {
            cell = theCell
        } else {
            cell = PreferenceBoolTableViewCell()
        }
        
        cell.viewModel = viewModel
        
        return cell
    }
    
    private func textCell(tableView: UITableView, viewModel: PreferenceTextViewModel) -> UITableViewCell
    {
        let cell: PreferenceTextTableViewCell
        if let theCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceTextTableViewCell.self)) as? PreferenceTextTableViewCell {
            cell = theCell
        } else {
            cell = PreferenceTextTableViewCell()
        }
        
        cell.viewModel = viewModel
        
        return cell
    }
    
    private func integerCell(tableView: UITableView, viewModel: PreferenceIntegerViewModel) -> UITableViewCell
    {
        let cell: PreferenceIntegerTableViewCell
        if let theCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PreferenceIntegerTableViewCell.self)) as? PreferenceIntegerTableViewCell {
            cell = theCell
        } else {
            cell = PreferenceIntegerTableViewCell()
        }
        
        cell.viewModel = viewModel
        
        return cell
    }
}
