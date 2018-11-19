//
//  ViewFlowGalileoFactory.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import Foundation

public final class ViewFlowGalileoFactory
{
    public init() {}
    
    public func viewFlow() -> GalileoPlugin
    {
        let view = ViewFlowGalileoTableViewController()
        
        return ViewFlowGalileoContainer(rootViewController: view)
    }
}
