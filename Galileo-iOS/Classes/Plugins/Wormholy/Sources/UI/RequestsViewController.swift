//
//  RequestsViewController.swift
//  Wormholy-iOS
//
//  Created by Paolo Musolino on 13/04/18.
//  Copyright © 2018 Wormholy. All rights reserved.
//

import UIKit

class RequestsViewController: WHBaseViewController
{
    @IBOutlet weak var collectionView: WHCollectionView!
    
    var filteredRequests: [RequestModel] = []
    var searchController: UISearchController?
    
    private var showingOnlyErrors = false
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: newRequestNotification, object: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        addSearchController()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .plain, target: self, action: #selector(openActionSheet))
        
        collectionView?.register(UINib(nibName: "RequestCell", bundle: Galileo.bundle), forCellWithReuseIdentifier: "RequestCell")
        
        filteredRequests = Storage.shared.requests
        
        NotificationCenter.default.addObserver(forName: newRequestNotification, object: nil, queue: nil) { [weak self] (notification) in
            DispatchQueue.main.sync { [weak self] in
                guard let welf = self else { return }
                
                welf.reloadRequestList()
            }
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            //Place code here to perform animations during the rotation.
            
        }) { (completionContext) in
            //Code here will execute after the rotation has finished.
            (self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 76)
            self.collectionView.reloadData()
        }
    }
    
    //  MARK: - Search
    
    private func addSearchController()
    {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        
        if #available(iOS 9.1, *) {
            searchController?.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback
        }
        
        searchController?.searchBar.placeholder = "Search URL"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            navigationItem.titleView = searchController?.searchBar
        }
        
        definesPresentationContext = true
    }
    
    private func filterRequests(text: String?, onlyErrors: Bool) -> [RequestModel]
    {
        if let text = text, text != "" {
            return Storage.shared.requests.filter { (request) -> Bool in
                let foundText = request.url.range(of: text, options: .caseInsensitive) != nil ? true : false
                let filterError = onlyErrors ? request.isError : true
                return foundText && filterError
            }
        } else {
            return Storage.shared.requests.filter { (request) -> Bool in
                return onlyErrors ? request.isError : true
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func openActionSheet()
    {
        let ac = UIAlertController(title: "Wormholy", message: "Choose an option", preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Clear", style: .default) { [weak self] (action) in
            self?.clearRequests()
        })
        ac.addAction(UIAlertAction(title: "Share", style: .default) { [weak self] (action) in
            self?.shareContent()
        })
        if showingOnlyErrors {
            ac.addAction(UIAlertAction(title: "Show all requests", style: .default) { [weak self] (action) in
                self?.showingOnlyErrors = false
                self?.reloadRequestList()
            })
        } else {
            ac.addAction(UIAlertAction(title: "Show only errors", style: .default) { [weak self] (action) in
                self?.showingOnlyErrors = true
                self?.reloadRequestList()
            })
        }
        ac.addAction(UIAlertAction(title: "Close", style: .cancel) { (action) in
        })
        
        present(ac, animated: true, completion: nil)
    }
    
    private func clearRequests()
    {
        Storage.shared.clearRequests()
        
        searchController?.searchBar.text = ""
        
        reloadRequestList()
    }
    
    private func shareContent()
    {
        var text = ""
        for request in filteredRequests{
            text = text + RequestModelBeautifier.txtExport(request: request)
        }
        
        let textShare = [text]
        let customItem = CustomActivity(title: "Save to the desktop", image: UIImage(named: "activity_icon", in: Galileo.bundle, compatibleWith: nil)) { (sharedItems) in
            guard let sharedStrings = sharedItems as? [String] else { return }
            
            for string in sharedStrings {
                FileHandler.writeTxtFileOnDesktop(text: string, fileName: "\(Int(Date().timeIntervalSince1970))-wormholy.txt")
            }
        }
        
        let activityViewController = UIActivityViewController(activityItems: textShare, applicationActivities: [customItem])
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func openRequestDetailVC(request: RequestModel)
    {
        let storyboard = UIStoryboard(name: "Flow", bundle: Galileo.bundle)
        if let requestDetailVC = storyboard.instantiateViewController(withIdentifier: "RequestDetailViewController") as? RequestDetailViewController {
            requestDetailVC.request = request
            
            show(requestDetailVC, sender: self)
        }
    }
    
    private func reloadRequestList()
    {
        filteredRequests = filterRequests(text: searchController?.searchBar.text, onlyErrors: showingOnlyErrors)
        collectionView.reloadData()
    }
}

extension RequestsViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return filteredRequests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCell", for: indexPath) as! RequestCell
        
        cell.populate(request: filteredRequests[indexPath.item])
        return cell
    }
}

extension RequestsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        openRequestDetailVC(request: filteredRequests[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.size.width, height: 100)
    }
}

// MARK: - UISearchResultsUpdating Delegate

extension RequestsViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        reloadRequestList()
    }
}
