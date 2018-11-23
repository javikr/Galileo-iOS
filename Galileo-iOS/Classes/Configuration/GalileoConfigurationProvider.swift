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
        return GalileoConfiguration(plugins: defaultPlugins())
    }
    
    public static func configuration(addingPlugins customPlugins: [GalileoPlugin]) -> GalileoConfiguration
    {
        let plugins = defaultPlugins() + customPlugins
        
        return GalileoConfiguration(plugins: plugins)
    }
    
    public static func configuration(withPlugins plugins: [GalileoPlugin]) -> GalileoConfiguration
    {
        return GalileoConfiguration(plugins: plugins)
    }
    
    private static func defaultPlugins() -> [GalileoPlugin]
    {
        let console = ConsoleLogGalileoFactory().consoleLogGalileo()
        let preferencesPlugin = PreferencesGalileoFactory().preferencesGalileo()
        let wormholy = WormholyGalileoPluginViewControllerFactory().wormholyGalileoPlugin()
        let viewFlowPlugin = ViewFlowGalileoFactory().viewFlow()

        return [console, preferencesPlugin, wormholy, viewFlowPlugin]
    }
}
