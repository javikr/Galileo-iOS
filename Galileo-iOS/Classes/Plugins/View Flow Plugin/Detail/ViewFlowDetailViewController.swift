//
//  ViewFlowDetailViewController.swift
//  Galileo-iOS
//
//  Created by Javier Aznar de los Rios on 19/11/2018.
//

import UIKit

class ViewFlowDetailViewController: UIViewController
{
    @IBOutlet var screenImage: UIImageView!
    @IBOutlet weak var viewScreenImageBack: UIView! {
        didSet {
            viewScreenImageBack.backgroundColor = UIColor.groupTableViewBackground
            viewScreenImageBack.layer.masksToBounds = false
            viewScreenImageBack.layer.shadowColor = UIColor.black.cgColor
            viewScreenImageBack.layer.shadowOpacity = 0.5
            viewScreenImageBack.layer.shadowOffset = CGSize(width: -1, height: 1)
            viewScreenImageBack.layer.shadowRadius = 1
        }
    }
    @IBOutlet weak var tableViewProperties: UITableView! {
        didSet {
            tableViewProperties.estimatedRowHeight = 100.0
            tableViewProperties.rowHeight = UITableView.automaticDimension
            tableViewProperties.dataSource = self
        }
    }
    
    private let screenView: ScreenView
    
    init(screenView: ScreenView)
    {
        self.screenView = screenView
        
        super.init(nibName: String(describing: ViewFlowDetailViewController.self), bundle: Galileo.bundle)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let cellName = String(describing: ViewFlowDetailTableViewCell.self)
        tableViewProperties.register(UINib(nibName: cellName, bundle: Galileo.bundle), forCellReuseIdentifier: cellName)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewFlowDetailViewController.close))
        
        title = screenView.name
        screenImage.image = screenView.screenshot
    }
    
    @objc private func close()
    {
        dismiss(animated: true, completion: nil)
    }
}

extension ViewFlowDetailViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return screenView.properties.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let propertyKey = screenView.properties.keys.sorted()[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ViewFlowDetailTableViewCell.self)) as? ViewFlowDetailTableViewCell
        
        if cell == nil {
            cell = Galileo.bundle.loadNibNamed(String(describing: ViewFlowDetailTableViewCell.self), owner: nil, options: nil)?.first as? ViewFlowDetailTableViewCell
        }
        
        cell?.propertyTitle = propertyKey
        
        let propertyValue = screenView.properties[propertyKey]!
        let value = (propertyValue as? CustomStringConvertible)?.description ?? (propertyValue as? CustomDebugStringConvertible)?.debugDescription ?? ""
        
        cell?.propertyValue = value
        
        return cell!
    }
}
