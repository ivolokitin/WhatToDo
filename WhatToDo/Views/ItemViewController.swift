//
//  ItemViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 30.04.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    // MARK:- Properties
    let items: [Item] = Item.itemList()
    
    // MARK:- Views
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 40)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generateItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupNavigation()
        setupViews()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            generateItem()
        }
    }
        
    // MARK:- Setup Navigation
        
    fileprivate func setupNavigation() {
    }
    
    // MARK:- Setup Views
    
    fileprivate func setupViews() {
        addViews()
        constrainViews()
    }
    fileprivate func addViews() {
        view.addSubview(itemLabel)
    }
    
    fileprivate func constrainViews() {
        itemLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        itemLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
    
    // MARK:- Handlers
    func generateItem() {
        let item = items.randomElement()
        itemLabel.text = item?.name
    }
}
