//
//  EditItemViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 05.05.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import UIKit
import CoreData

protocol EditItemDelegate {
    func editItem(userItem: UserItem, index: Int)
}

class EditItemViewController: UIViewController {

    // MARK:- Properties
    
    var index: Int?
    var userItem: UserItem?

    var delegate: EditItemDelegate?
    
    // MARK:- Views
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What to do"
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 40)
        
        textField.borderStyle = .none
        textField.frame.size.width = 300
        textField.frame.size.height = 50
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.systemOrange.cgColor
        bottomLine.masksToBounds = true
        textField.layer.addSublayer(bottomLine)

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 25
        button.contentEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(okButton_touchedUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK:- Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigation()
        setupViews()
        getUserItem()
    }
    
    func getUserItem() {
        guard let userItem = userItem else { return }
        nameTextField.text = userItem.name
    }

        
    // MARK:- Setup Navigation
        
    fileprivate func setupNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    // MARK:- Setup Views
    
    fileprivate func setupViews() {
        addViews()
        constrainViews()
    }
    fileprivate func addViews() {
        view.addSubview(nameTextField)
        view.addSubview(okButton)
    }
    
    fileprivate func constrainViews() {
        nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        okButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        okButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 150).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK:- Handlers
    
    @objc func okButton_touchedUpInside() {
        guard let name = nameTextField.text, nameTextField.hasText else { return }
        
        if let userItem = userItem {
            userItem.name = name
            guard let index = index else { return }
            delegate?.editItem(userItem: userItem, index: index)
        }
    }
}
