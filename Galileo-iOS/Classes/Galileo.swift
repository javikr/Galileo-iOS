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
    
    public init(frame: CGRect, customPlugins: [GalileoPlugin] = [])
    {
        let preferencesPlugin = PreferencesGalileoFactory().preferencesGalileo()
        let console = ConsoleLogGalileoFactory().consoleLogGalileo()
        let wormholy = WormholyGalileoPluginViewController()
        
        self.plugins = [preferencesPlugin, console, wormholy] + customPlugins
        
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
    
    override open func makeKeyAndVisible()
    {
        super.makeKeyAndVisible()
        
        setupPlugins()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        guard motion == .motionShake else { return }
        
        if isGalileoCurrentlyPresented() {
            dismissGalileo()
        } else {
            launchGalileo()
        }
    }
    
    private func launchGalileo()
    {
        let mainView = MainViewControllerFactory().mainViewController(plugins: plugins)
        self.rootViewController?.present(mainView, animated: true)
    }
    
    private func dismissGalileo()
    {
        rootViewController?.presentedViewController?.dismiss(animated: true)
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
