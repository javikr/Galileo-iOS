//
//  ViewFlowDetailViewController.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit

class ViewFlowDetailViewController: UIViewController {

    @IBOutlet var screenImage: UIImageView!
    
    var screenView: ScreenView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        title = screenView?.name
        screenImage.image = screenView?.screenshot
    }
}
