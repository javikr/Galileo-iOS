//
//  ViewFlowGalileoTableViewController.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit

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
        
        let detailView = ViewFlowDetailViewController(nibName: String(describing: ViewFlowDetailViewController.self), bundle: Galileo.bundle)
        detailView.screenView = view
        
        navigationController?.pushViewController(detailView, animated: true)
    }
}
