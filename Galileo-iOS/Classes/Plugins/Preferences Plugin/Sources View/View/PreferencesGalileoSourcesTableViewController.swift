//
//  PreferencesGalileoSourcesTableViewController.swift
//  Galileo-iOS
//
//  Created by Javier Aznar on 19/11/2018.
//

import UIKit

class PreferencesGalileoSourcesTableViewController: UITableViewController
{
    private let sources: [UserDefaults]
    
    init(sources: [UserDefaults])
    {
        self.sources = sources
        
        super.init(nibName: String(describing: PreferencesGalileoSourcesTableViewController.self), bundle: Galileo.bundle)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Preferences Manager"
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}

extension PreferencesGalileoSourcesTableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let source = sources[indexPath.row]
        
        let cell: UITableViewCell
        if let theCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = theCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = source.description
        cell.detailTextLabel?.text = String("Total: \(source.dictionaryRepresentation().keys.count)")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let source = sources[indexPath.row]
        
        let preferencesView = PreferencesGalileoViewDetailFactory().preferencesGalileoView(userDefaultsSource: source)
        navigationController?.pushViewController(preferencesView, animated: true)
    }
}
