//
//  ViewFlowGalileoContainer.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit

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
    
    @objc func customViewDidAppear()
    {
        guard !self.isKind(of: UINavigationController.self), !self.isKind(of: UITabBarController.self) else { return }
        
        guard let image = takeScreenshot() else { return }
        
        let screenView = ScreenView(name: String(describing: type(of: self)), screenshot: image)
        notifyNewScreen(screenView: screenView)
    }
    
    private func notifyNewScreen(screenView: ScreenView)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addNewViewNotification"), object: nil, userInfo: ["screenView": screenView])
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
        swizzling(forClass: UIViewController.self, originalSelector: #selector(UIViewController.viewDidAppear(_:)), toClass: ViewFlowGalileoContainer.self, swizzledSelector: #selector(ViewFlowGalileoContainer.customViewDidAppear))
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
