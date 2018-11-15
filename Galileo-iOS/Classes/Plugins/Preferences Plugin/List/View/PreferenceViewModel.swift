//
//  PreferenceType.swift
//  Alamofire
//
//  Created by Javier Aznar on 15/11/2018.
//

import Foundation

enum PreferenceViewModel
{
    case boolean(key: String, value: Bool)
    case text(key: String, value: String)
    case other(key: String, value: Any)
}
