//
//  PreferenceViewTypeMapper.swift
//  Alamofire
//
//  Created by Javier Aznar on 16/11/2018.
//

import Foundation

struct PreferenceViewTypeMapper
{
    func transform(fromKey key: String, value: Any) -> PreferenceViewType
    {
        switch value {
        case is Bool: return PreferenceViewType.boolean(key: key, viewModel: PreferenceBoolViewModel(title: key, value: value as! Bool))
        case is Int: return PreferenceViewType.integer(key: key, viewModel: PreferenceIntegerViewModel(title: key, value: value as! Int))
        case is String: return PreferenceViewType.text(key: key, viewModel: PreferenceTextViewModel(title: key, value: value as! String))
        case is Date: return PreferenceViewType.date(key: key, viewModel: PreferenceDateViewModel(title: key, value: value as! Date))
        default: return PreferenceViewType.other(key: key, viewModel: PreferenceTextViewModel(title: key, value: (value as AnyObject).debugDescription ?? ""))
        }
    }
}
