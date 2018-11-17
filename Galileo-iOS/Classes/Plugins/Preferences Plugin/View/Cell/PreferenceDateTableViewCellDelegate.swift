//
//  PreferenceDateTableViewCellDelegate.swift
//  Alamofire
//
//  Created by Javier Aznar de los Rios on 17/11/2018.
//

import Foundation

protocol PreferenceDateTableViewCellDelegate: PreferenceTableViewCellDelegate
{
    func didToggleDisplayDate(hide: Bool, key: String)
}
