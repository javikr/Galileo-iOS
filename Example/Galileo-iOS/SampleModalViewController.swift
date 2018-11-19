//
//  SampleModalViewController.swift
//  Galileo-iOS_Example
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class SampleModalViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // sample
    }

    @IBAction func didTapClose(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
}
