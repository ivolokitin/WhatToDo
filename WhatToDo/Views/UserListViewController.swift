//
//  UserListViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 01.05.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import UIKit
import CoreData

class UserListViewController: UIViewController, UISearchBarDelegate {

    // MARK:- Properties
    //var userItems: [Item] = [Item]()
    
    var userItemsList = [UserItem]()
    var filteredData = [UserItem]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let reuseIdentifier = "UserListReuseIdentifier"
    
    var tableView = UITableView()
    
    // MARK:- Views
    
    let backgroundHintLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.text = "Add your own WhatToDo's"
        label.textAlignment = .center
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 40)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 35
        button.contentEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(plusButton_touchedUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.backgroundColor = .systemYellow
        return searchBar
    }()

    // MARK:- Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundHintLabel.isHidden = userItemsList.count == 0 ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        loadData()
        setupNavigation()
        setupViews()
        setupTableView()
        
        searchBar.delegate = self
    }
       
    // MARK:- Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            loadData()
        } else {
            loadData()
            userItemsList = userItemsList.filter {
                $0.name?.range(of: searchText, options: .caseInsensitive) != nil
            }
        }

        tableView.reloadData()
        //print(searchText)
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
        view.addSubview(tableView)
        view.addSubview(backgroundHintLabel)
        view.addSubview(plusButton)
    }
    
    fileprivate func constrainViews() {
        backgroundHintLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        backgroundHintLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    fileprivate func setupTableView() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 485.0
        tableView.rowHeight = UITableView.automaticDimension

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemYellow
        
        tableView.tableHeaderView = searchBar
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK:- Handlers

    @objc func plusButton_touchedUpInside() {
        let addItemVC = AddItemViewController()
        addItemVC.delegate = self
        navigationController?.pushViewController(addItemVC, animated: true)
    }

    // MARK:- Core Data
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context")
        }
        
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<UserItem> = UserItem.fetchRequest()) {
        do {
            userItemsList = try context.fetch(request)
        } catch {
            print("Error fetching data from context")
        }
        
        tableView.reloadData()
    }
    
    func deleteData(object: UserItem) {
        context.delete(object)
    }
}

extension UserListViewController: AddItemDelegate {
    
    func addItem(userItem: UserItem) {
        navigationController?.popViewController(animated: true)
        userItemsList.append(userItem)
        saveData()
    }
}

extension UserListViewController: EditItemDelegate {
    
    func editItem(userItem: UserItem, index: Int) {
        //print(index)
        navigationController?.popViewController(animated: true)
        
        //deleteData(object: userItemsList[index])
        //userItemsList.remove(at: index)
        
        userItemsList[index] = userItem
        saveData()
        loadData()
        
        //print(userItemsList.map {$0.name})
        //print(userItem.name)
        //userItemsList[index] = userItem
        //print(index)
        //print(userItemsList.map {$0.name})
        //print(userItem.name)

        
        //saveData()
        //print(userItemsList.map {$0.name})
        
        //tableView.reloadData()
        //userItemsList.removeLast()
        //print(userItemsList.map {$0.name})
        //print(userItem.name)

        //tableView.reloadData()
        //loadData()
        
        //userItemsList.remove(at: index)
        //userItemsList.insert(userItem, at: index)
        
        
        //saveData()
        //deleteData(object: userItemsList[index])
        
        
        //saveData()
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to create cell")
        }
        cell.nameLabel.text = userItemsList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, boolValue) in

            let editItemVC = EditItemViewController()
            editItemVC.delegate = self

            editItemVC.index = indexPath.row
            print(indexPath.row)
            editItemVC.userItem = self.userItemsList[indexPath.row]
            
            self.navigationController?.pushViewController(editItemVC, animated: true)
        }
        editAction.image = UIImage(systemName: "pencil.circle")
        editAction.backgroundColor = .systemYellow
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, boolValue) in
            self.deleteData(object: self.userItemsList[indexPath.row])
            self.userItemsList.remove(at: indexPath.row)
            self.saveData()
            self.loadData()
        }
        deleteAction.image = UIImage(systemName: "trash.circle")
        deleteAction.backgroundColor = .systemYellow
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return swipeActions
    }
}

class CustomTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let rearView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemYellow
        contentView.addSubview(rearView)
        
        rearView.layer.cornerRadius = 20
        rearView.backgroundColor = .white
        rearView.translatesAutoresizingMaskIntoConstraints = false
        rearView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: -5).isActive = true
        rearView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: -10).isActive = true
        rearView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 10).isActive = true
        rearView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 5).isActive = true

        rearView.addSubview(nameLabel)

        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: rearView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: rearView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: rearView.trailingAnchor, constant: -20).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: rearView.bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
