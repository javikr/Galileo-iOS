//
//  ConsoleLogGalileoContainerViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class ConsoleLogGalileoContainerViewController: UINavigationController {}

extension ConsoleLogGalileoContainerViewController: GalileoPlugin
{
    var pluginName: String {
        return "Console"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "200-terminal", in: Bundle(for: ConsoleLogGalileoContainerViewController.self), compatibleWith: nil)
    }
    
    func setupPlugin()
    {
        redirectConsoleLogToDocumentFolder()
    }
    
    var consoleLogFilePath: String {
        let allPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = allPaths.first!
        let pathForLog = (documentsDirectory as NSString).appending("/console.log")
        return pathForLog
    }
    
    private func redirectConsoleLogToDocumentFolder()
    {
        freopen(consoleLogFilePath.cString(using: String.Encoding.ascii)!, "a+", stderr)
        
        // test
        print(consoleLogFilePath)
    }
}
