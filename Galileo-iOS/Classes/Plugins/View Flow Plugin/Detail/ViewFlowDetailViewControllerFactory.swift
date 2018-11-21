//
//  File.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 21/11/2018.
//

import Foundation

class ViewFlowDetailViewControllerFactory
{
    func flowViewDetail(screenView: ScreenView) -> UIViewController
    {
        let view = ViewFlowDetailViewController(screenView: screenView)
        
        return UINavigationController(rootViewController: view)
    }
}
