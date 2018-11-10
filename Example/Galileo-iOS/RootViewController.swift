//
//  RootViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 08/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // TEST
        
        UserDefaults.standard.set(false, forKey: "key test1")
        UserDefaults.standard.set("prueba", forKey: "key test2")
        
        print("test log") // no funca!
        NSLog("test log 2")
        
        demoAlamofireCall()
    }
    
    private func demoAlamofireCall()
    {
        Alamofire.request("https://www.todorock.com/wp-json/wp/v2/posts")
    }
}
