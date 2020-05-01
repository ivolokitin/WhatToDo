//
//  OnboardViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 30.04.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import Foundation
import UIKit

class OnboardViewController: UIViewController {

    // MARK:- Properties
    
    // MARK:- Views

    let whatLabel: UILabel = {
        let label = UILabel()
        label.text = "What"
        label.textColor = .systemTeal
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.shadowOffset = CGSize(width: 0, height: 5)
        label.shadowColor = .systemGray4
        return label
    }()
    
    let toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.textColor = .systemTeal
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 75)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.shadowOffset = CGSize(width: 0, height: 5)
        label.shadowColor = .systemGray4
        return label
    }()
    
    let doLabel: UILabel = {
        let label = UILabel()
        label.text = "Do"
        label.textColor = .systemTeal
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 125)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.shadowOffset = CGSize(width: 0, height: 5)
        label.shadowColor = .systemGray4
        return label
    }()
    
    let tapButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 50)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 25
        button.contentEdgeInsets = UIEdgeInsets(top: -12, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(tapButton_touchedUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap plus button\nor shake your iPhone"
        label.numberOfLines = 0
        label.textColor = .systemGray5
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigation()
        setupViews()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            navigationController?.pushViewController(ItemViewController(), animated: true)
        }
    }
    
    // MARK:- Setup Navigation
        
    fileprivate func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    // MARK:- Setup Views
    
    fileprivate func setupViews() {
        addViews()
        constrainViews()
    }
    fileprivate func addViews() {
        view.addSubview(whatLabel)
        view.addSubview(toLabel)
        view.addSubview(doLabel)
        view.addSubview(tapButton)
        view.addSubview(hintLabel)
    }
    
    fileprivate func constrainViews() {
        whatLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        whatLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        toLabel.topAnchor.constraint(equalTo: whatLabel.bottomAnchor, constant: -30).isActive = true
        toLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 28).isActive = true
        
        doLabel.topAnchor.constraint(equalTo: whatLabel.bottomAnchor, constant: -43).isActive = true
        doLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 0).isActive = true

        hintLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        hintLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

        tapButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tapButton.bottomAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: -100).isActive = true
        tapButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK:- Handlers
    
    @objc func tapButton_touchedUpInside() {
        navigationController?.pushViewController(ItemViewController(), animated: true)
    }

}
