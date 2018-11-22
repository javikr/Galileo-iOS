//
//  ConsoleLogGalileoViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit
import MessageUI

class ConsoleLogGalileoViewController: UIViewController
{
    @IBOutlet weak var consoleTextView: UITextView! {
        didSet {
            consoleTextView.backgroundColor = .black
            consoleTextView.textColor = .white
            consoleTextView.isEditable = false
        }
    }
    
    var consoleLogFilePath: String? {
        return (navigationController as? ConsoleLogGalileoContainerViewController)?.consoleLogFilePath
    }
    
    let notificationCenter = NotificationCenter.default
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        notificationCenter.addObserver(self, selector: #selector(ConsoleLogGalileoViewController.applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationItem.title = "Console Manager"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(ConsoleLogGalileoViewController.clearLog))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ConsoleLogGalileoViewController.shareLog))
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        loadConsoleFile()
        scrollTextViewToBottom()
    }
    
    @objc private func shareLog()
    {
        guard MFMailComposeViewController.canSendMail() else { return }
        guard let text = try? read(filename: Galileo.consoleLogFilename) else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setMessageBody(text, isHTML: false)
        mailComposer.setSubject("Console log")
        mailComposer.mailComposeDelegate = self
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    @objc private func clearLog()
    {
        guard let logPath = consoleLogFilePath else { return }
        
        try? FileManager.default.removeItem(atPath: logPath)
        
        loadConsoleFile()
    }
    
    @objc func applicationDidBecomeActive(notification: Notification)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        let dateValue = dateFormatter.string(from: Date())
        
        try? write("", toFilename: Galileo.consoleLogFilename)
        try? write("------------------------------", toFilename: Galileo.consoleLogFilename)
        try? write("---> " + dateValue + " <---", toFilename: Galileo.consoleLogFilename)
        try? write("------------------------------", toFilename: Galileo.consoleLogFilename)
        try? write("", toFilename: Galileo.consoleLogFilename)
    }
    
    private func loadConsoleFile()
    {
        guard let logPath = consoleLogFilePath else { return }
        
        let fileContents = try? String(contentsOfFile: logPath)
        
        consoleTextView.text = fileContents
    }
    
    private func scrollTextViewToBottom()
    {
        let bottom = NSMakeRange(consoleTextView.text.count - 1, 1)
        consoleTextView.scrollRangeToVisible(bottom)
    }
}

extension ConsoleLogGalileoViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
