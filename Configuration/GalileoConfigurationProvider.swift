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
    
    private static func defaultPlugins() -> [GalileoPlugin]
    {
        let preferencesPlugin = PreferencesGalileoFactory().preferencesGalileo()
        let console = ConsoleLogGalileoFactory().consoleLogGalileo()
        let wormholy = WormholyGalileoPluginViewController()
        
        return [console, preferencesPlugin, wormholy]
    }
}
