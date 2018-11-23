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
        let consolePlugin = ConsoleLogGalileoFactory().consoleLogGalileo()
        let preferencesPlugin = PreferencesGalileoFactory().preferencesGalileo()
        let wormholyPlugin = WormholyGalileoPluginViewControllerFactory().wormholyGalileoPlugin()
        let viewFlowPlugin = ViewFlowGalileoFactory().viewFlow()

        return [consolePlugin, preferencesPlugin, wormholyPlugin, viewFlowPlugin]
    }
}
