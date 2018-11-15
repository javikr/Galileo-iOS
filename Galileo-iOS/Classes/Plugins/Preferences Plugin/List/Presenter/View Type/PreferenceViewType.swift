//
//  PreferenceType.swift
//  Alamofire
//
//  Created by Javier Aznar on 15/11/2018.
//

import Foundation

enum PreferenceViewType
{
    case boolean(key: String, viewModel: PreferenceBoolViewModel)
    case text(key: String, viewModel: PreferenceTextViewModel)
    case integer(key: String, viewModel: PreferenceIntegerViewModel)
    case other(key: String, viewModel: PreferenceTextViewModel)
}
