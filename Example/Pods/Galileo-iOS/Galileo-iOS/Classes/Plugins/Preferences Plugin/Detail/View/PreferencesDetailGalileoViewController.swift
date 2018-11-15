//
//  PreferencesDetailGalileoViewController.swift
//  Galileo
//
//  Created by Javier Aznar de los Rios on 09/11/2018.
//  Copyright © 2018 The Clash Soft. All rights reserved.
//

import UIKit

class PreferencesDetailGalileoViewController: UIViewController
{
    @IBOutlet weak var preferenceKey: UILabel! {
        didSet {
            preferenceKey.textColor = .black
            preferenceKey.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        }
    }
    @IBOutlet weak var save: UIButton! {
        didSet {
            save.setTitle("Save", for: .normal)
            save.setTitleColor(.white, for: .normal)
            save.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
            save.backgroundColor = .green
            save.layer.cornerRadius = 3.0
            save.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var delete: UIButton! {
        didSet {
            delete.setTitle("Delete", for: .normal)
            delete.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
            delete.setTitleColor(.white, for: .normal)
            delete.backgroundColor = .red
            delete.layer.cornerRadius = 3.0
            delete.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var viewContainer: UIView! {
        didSet {
            viewContainer.backgroundColor = .groupTableViewBackground
            viewContainer.layer.cornerRadius = 3.0
            viewContainer.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var preferenceValue: UITextField! {
        didSet {
            preferenceValue.textColor = .darkGray
            preferenceValue.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        }
    }
    
    var eventHandler: PreferencesDetailGalileoPresenterInterface!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        eventHandler.viewLoaded()
    }
    
    @IBAction func didTapSaveButton(_ sender: Any)
    {
        guard let valueText = preferenceValue.text else { return }
        
        eventHandler.didTapSave(value: valueText)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any)
    {
        eventHandler.didTapDelete()
    }
}

extension PreferencesDetailGalileoViewController: PreferencesDetailGalileoViewInterface
{
    func configureView(withViewModel viewModel: PreferencesDetailGalileoViewModel)
    {
        preferenceKey.text = viewModel.key
        preferenceValue.text = viewModel.value
    }
}
