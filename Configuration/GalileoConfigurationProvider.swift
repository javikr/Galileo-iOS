//
//  GalileoConfigurationProvider.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import Foundation

public struct GalileoConfigurationProvider
{
    public static func defaultConfiguration() -> GalileoConfiguration
    {
        return GalileoConfiguration(plugins: defaultPlugins(), userDefaultsSources: [UserDefaults.standard])
    }
    
    public static func customConfiguration(plugins: [GalileoPlugin], userDefaultsSources: [UserDefaults]) -> GalileoConfiguration
    {
        let completePlugins = defaultPlugins() + plugins 
        
        return GalileoConfiguration(plugins: completePlugins, userDefaultsSources: userDefaultsSources)
    }
    
    private static func defaultPlugins() -> [GalileoPlugin]
    {
        let preferencesPlugin = PreferencesGalileoFactory().preferencesGalileo()
        let console = ConsoleLogGalileoFactory().consoleLogGalileo()
        let wormholy = WormholyGalileoPluginViewController()
        
        return [console, preferencesPlugin, wormholy]
    }
}
