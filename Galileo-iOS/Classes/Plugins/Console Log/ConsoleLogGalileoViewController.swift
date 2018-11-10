//
//  ConsoleLogGalileoViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class ConsoleLogGalileoViewController: UIViewController
{
    @IBOutlet weak var clearButton: UIButton! {
        didSet {
            clearButton.setTitle("Clear", for: .normal)
            clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
            clearButton.setTitleColor(.green, for: .normal)
            clearButton.backgroundColor = .darkGray
            clearButton.layer.cornerRadius = 3.0
            clearButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var consoleTextView: UITextView! {
        didSet {
            consoleTextView.backgroundColor = .black
            consoleTextView.textColor = .white
        }
    }
    
    var consoleLogFilePath: String? {
        return (navigationController as? ConsoleLogGalileoContainerViewController)?.consoleLogFilePath
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationItem.title = "Console Manager"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        loadConsoleFile()
    }

    @IBAction func didTapClearButton(_ sender: Any)
    {
        guard let logPath = consoleLogFilePath else { return }
        
        try? FileManager.default.removeItem(atPath: logPath)
        
        loadConsoleFile()
    }
    
    private func loadConsoleFile()
    {
        guard let logPath = consoleLogFilePath else { return }
        
        let fileContents = try? String(contentsOfFile: logPath)
        
        consoleTextView.text = fileContents
    }
}
