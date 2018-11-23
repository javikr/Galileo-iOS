//
//  ViewFlowGalileoContainer.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit
import MessageUI

class ViewFlowGalileoContainer: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    // Swizzled method
    @objc func customViewWillDissapear()
    {
        guard !self.isKind(of: UINavigationController.self), !self.isKind(of: UITabBarController.self), !self.isKind(of: UIPageViewController.self), !self.isKind(of: MFMailComposeViewController.self) else { return }
        
        // 1) take screenshot
        guard let image = self.takeScreenshot() else { return }
        
        // 2) obtain view controller name
        let viewControllerName = String(describing: type(of: self))
        try? write(viewControllerName, toFilename: Galileo.viewFlowLogFilename)
        
        // 3) obtain view controller properties
        let mirror = Mirror(reflecting: self)
        let propertyNames = mirror.children.compactMap{ $0.label }
        let propertyValues = mirror.children.compactMap{ $0.value }
        
        DispatchQueue.global(qos: .background).async {
            var properties: [String: Any] = [:]
            
            if propertyNames.count == propertyValues.count {
                for (index, propertyName) in propertyNames.enumerated() {
                    let value = propertyValues[index]
                    
                    // PLEASE NOTE: fix to avoid crash for big property values!
                    guard value is Bool || value is Int || value is String || value is Double || value is Float || value is CGFloat else { continue }
                    properties[propertyName] = value
                }
            }
            
            let screenView = ScreenView(name: viewControllerName, screenshot: image, properties: properties)
            
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "addNewViewNotification"), object: nil, userInfo: ["screenView": screenView])
            }
        }
    }
    
    private func takeScreenshot() -> UIImage?
    {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshotImage
    }
}

extension ViewFlowGalileoContainer: GalileoPlugin
{
    var pluginName: String {
        return "View Flow"
    }
    
    var pluginIcon: UIImage? {
        return UIImage(named: "smartphone", in: Galileo.bundle, compatibleWith: nil)
    }
    
    func setupPlugin()
    {
        swizzling(forClass: UIViewController.self, originalSelector: #selector(UIViewController.viewWillDisappear(_:)), toClass: ViewFlowGalileoContainer.self, swizzledSelector: #selector(ViewFlowGalileoContainer.customViewWillDissapear))
    }
    
    private func swizzling(forClass: AnyClass, originalSelector: Selector, toClass: AnyClass, swizzledSelector: Selector)
    {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(toClass, swizzledSelector)
        
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
