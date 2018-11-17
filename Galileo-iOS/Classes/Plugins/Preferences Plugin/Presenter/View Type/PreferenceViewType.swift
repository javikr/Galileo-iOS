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
    case date(key: String, viewModel: PreferenceDateViewModel)
    case other(key: String, viewModel: PreferenceTextViewModel)
    
    var key: String {
        switch self {
        case .boolean(let key, _): return key
        case .text(let key, _): return key
        case .integer(let key, _): return key
        case .date(let key, _): return key
        case .other(let key, _): return key
        }
    }
    
    var isViewCollapsed: Bool {
        guard case let PreferenceViewType.date(_, viewModel) = self else { return true }
        
        return viewModel.isViewCollapsed
    }
}
