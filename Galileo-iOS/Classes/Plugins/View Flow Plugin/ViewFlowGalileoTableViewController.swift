//
//  ViewFlowGalileoTableViewController.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit
import MessageUI

class ViewFlowGalileoTableViewController: UITableViewController
{
    var views: [ScreenView] = []
    
    private var lastViews: [ScreenView] {
        return Array(views.suffix(100))
    }
    
    private let notificationCenter = NotificationCenter.default
    private var galileoIsShowing: Bool = false
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        notificationCenter.addObserver(self, selector: #selector(ViewFlowGalileoTableViewController.addNewViewNotification(notification:)), name: Notification.Name(rawValue: "addNewViewNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewFlowGalileoTableViewController.galileoStartedNotification(notification:)), name: Notification.Name(rawValue: "GalileoStartedNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewFlowGalileoTableViewController.galileoStoppedNotification(notification:)), name: Notification.Name(rawValue: "GalileoStoppedNotification"), object: nil)
        notificationCenter.addObserver(self, selector: #selector(ConsoleLogGalileoViewController.applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "View Flow"
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ViewFlowGalileoTableViewController.shareLog))
        
        let cellName = String(describing: ViewFlowTableViewCell.self)
        tableView.register(UINib(nibName: cellName, bundle: Galileo.bundle), forCellReuseIdentifier: cellName)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        purgeOldViews()
        
        tableView.reloadData()
    }
    
    @objc func addNewViewNotification(notification: Notification)
    {
        guard !galileoIsShowing, let screenView = notification.userInfo?["screenView"] as? ScreenView else { return }
    
        views.append(screenView)
    }
    
    @objc func galileoStartedNotification(notification: Notification)
    {
        galileoIsShowing = true
    }
    
    @objc func galileoStoppedNotification(notification: Notification)
    {
        galileoIsShowing = false
    }
    
    @objc func applicationDidBecomeActive(notification: Notification)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        let dateValue = dateFormatter.string(from: Date())
        
        try? write("", toFilename: Galileo.viewFlowLogFilename)
        try? write("------------------------------", toFilename: Galileo.viewFlowLogFilename)
        try? write("---> " + dateValue + " <---", toFilename: Galileo.viewFlowLogFilename)
        try? write("------------------------------", toFilename: Galileo.viewFlowLogFilename)
        try? write("", toFilename: Galileo.viewFlowLogFilename)
    }
    
    @objc private func shareLog()
    {
        guard MFMailComposeViewController.canSendMail() else { return }
        guard let text = try? read(filename: Galileo.viewFlowLogFilename) else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.setMessageBody(text, isHTML: false)
        mailComposer.setSubject("View Flow log")
        mailComposer.mailComposeDelegate = self
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    private func purgeOldViews()
    {
        guard views.count - 100 > 0 else { return }
        
        let numberToDelete = views.count - 100
        views = Array(views.dropFirst(numberToDelete))
    }
}

extension ViewFlowGalileoTableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lastViews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let view = lastViews[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewFlowTableViewCell.self)) as? ViewFlowTableViewCell
        
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: ViewFlowTableViewCell.self), owner: nil, options: nil)?.first as? ViewFlowTableViewCell
        }

        cell?.viewModel = ViewFlowTableViewCellViewModel(image: view.screenshot, viewName: view.name, viewParams: view.properties.description)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let view = lastViews[indexPath.row]
        
        let detailView = ViewFlowDetailViewControllerFactory().flowViewDetail(screenView: view)
        
        present(detailView, animated: true, completion: nil)
    }
}

extension ViewFlowGalileoTableViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
}
