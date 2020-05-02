//
//  AddItemViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 01.05.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import UIKit
import CoreData

protocol AddItemDelegate {
    func addItem(userItem: UserItem)
}

class AddItemViewController: UIViewController {

    // MARK:- Properties
    var delegate: AddItemDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK:- Views
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What to do"
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 40)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        // textField.autocorrectionType = UITextAutocorrectionType.no
        // textField.keyboardType = UIKeyboardType.default
        // textField.returnKeyType = UIReturnKeyType.done
        // textField.clearButtonMode = UITextField.ViewMode.whileEditing
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigation()
        setupViews()
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
        //let item = Item(name: name)
        let userItem = UserItem(context: context)
        userItem.name = name
        delegate?.addItem(userItem: userItem)
    }
}
