//
//  PreferenceBoolTableViewCellDelegate.swift
//  Alamofire
//
//  Created by Javier Aznar on 16/11/2018.
//

import Foundation

protocol PreferenceTableViewCellDelegate: class
{
    func didUpdate(value: Any, forKey key: String)
}
