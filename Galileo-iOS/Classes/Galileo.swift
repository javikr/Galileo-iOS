//
//  Galileo.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

/**
 UIWindow subclass that works with Galileo. **You must use this Window class in your AppDelegate file**
 
 ### Usage Example: ###
 ````
 window = Galileo(frame: UIScreen.main.bounds)
 
 ````
 
 */
open class Galileo: UIWindow
{
    private var plugins: [GalileoPlugin]
    private var mainView: UIViewController?
    private let notificationCenter = NotificationCenter.default

    public init(frame: CGRect, configuration: GalileoConfiguration = GalileoConfigurationProvider.defaultConfiguration())
    {
        self.plugins = configuration.plugins
                
        super.init(frame: frame)
    }
    
    public func add(plugin: GalileoPlugin)
    {
        plugins.append(plugin)
    }
    
    static var bundle: Bundle {
        let url = Bundle(for: Galileo.self).url(forResource: "Galileo", withExtension: "bundle")
        return Bundle(url: url!)!
    }
    
    static let consoleLogFilename: String = "console.log"
    static let viewFlowLogFilename: String = "view_flow.log"
    
    override open func makeKeyAndVisible()
    {
        super.makeKeyAndVisible()
        
        setupPlugins()
        
        if mainView == nil {
            mainView = MainViewControllerFactory().mainViewController(plugins: plugins)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) { return nil }
    
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        guard motion == .motionShake else { return }
        
        if isGalileoCurrentlyPresented() {
            dismissGalileo()
        } else {
            launchGalileo()
        }
    }
    
    public func dismissGalileo(completion: (() -> Void)? = nil)
    {
        rootViewController?.presentedViewController?.dismiss(animated: true, completion: { [weak self] in
            self?.notificationCenter.post(name: Notification.Name(rawValue: "GalileoStoppedNotification"), object: nil)
            completion?()
        })
    }
    
    public func launchGalileo()
    {
        notificationCenter.post(name: Notification.Name(rawValue: "GalileoStartedNotification"), object: nil)

        rootViewController?.present(mainView!, animated: true)
    }

    private func setupPlugins()
    {
        for plugin in plugins {
            plugin.setupPlugin()
        }
    }
    
    private func isGalileoCurrentlyPresented() -> Bool
    {
        guard let presentedViewController = rootViewController?.presentedViewController, presentedViewController.isKind(of: GalileoMainViewController.self) else { return false }
        
        return true
    }
}
