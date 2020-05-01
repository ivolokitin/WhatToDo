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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 35
        button.contentEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(nextButton_touchedUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let doItButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do it", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.contentEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(doItButton_touchedUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(slideToLeftWithGestureRecognizer))
        swipeGesture.direction = .left
        view.addGestureRecognizer(swipeGesture)
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
        view.addSubview(doItButton)
        view.addSubview(nextButton)
    }
    
    fileprivate func constrainViews() {
        itemLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        itemLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        doItButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        doItButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120).isActive = true
        doItButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        doItButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        nextButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: doItButton.topAnchor, constant: -20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    // MARK:- Handlers
    
    @objc func nextButton_touchedUpInside() {
        generateItem()
    }
    
    @objc func doItButton_touchedUpInside() {
        
    }
    
    @objc func slideToLeftWithGestureRecognizer() {
        generateItem()
    }
    
    func generateItem() {
        let item = items.filter { $0.name != itemLabel.text }.randomElement()
        itemLabel.text = item?.name
    }
}
