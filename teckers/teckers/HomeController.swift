//
//  HomeController.swift
//  teckers
//
//  Created by Maggie Mendez on 8/23/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var addMessageButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var messagesList : [MessagesUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        messagesList = []
        getMessages(priorityHigh: true)
        
    }
    func getMessages(priorityHigh : Bool) {
        MessagesLists(success: { [weak self] (backendMessages) in
            if let view = self{
                view.messagesList = backendMessages
                DispatchQueue.main.async {
                    view.messageTableView.reloadData()
                }
            }
        }, onFailure: { (error) in
            let alertAction = Alert(title: "Error", massage: error.localizedDescription, type: 0)
            self.present(alertAction.show(), animated: true, completion: nil)
        }, priority: priorityHigh )
    }
    
    @IBAction func changeSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            getMessages(priorityHigh: true)
        }
        else {
            getMessages(priorityHigh: false)
        }
    }
    
    func setupUI() {
        setupTableView()
        setupNavigateBar()
        setupAddMessageButton()
    }
    func setupAddMessageButton(){
        addMessageButton.backgroundColor = Color.purpure
        addMessageButton.layer.cornerRadius = addMessageButton.frame.height / 2
        addMessageButton.isHidden = true
        segmentedControl.setTitle("High Priority", forSegmentAt: 0)
        segmentedControl.setTitle("Low Priority", forSegmentAt: 1)
    }
    
    func setupTableView(){
        let delegateHigh = MessagesTableViewDelegate()
        messageTableView.delegate = delegateHigh
        messageTableView.dataSource = self
        
        messageTableView.register(MessageCell.nibName, forCellReuseIdentifier: MessageCell.NameCell)
    }
    
}

extension HomeController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.NameCell, for: indexPath) as! MessageCell
        let message = messagesList[indexPath.row]
        cell.setFriendMessages(friend: message)
        return cell
    }
}
extension UITableViewDelegate{
}

extension HomeController : UISearchBarDelegate {
    func setupNavigateBar(){
        
        let searchController = UISearchController(searchResultsController: nil)
        let delegate = SearchBarFilter {
            self.messageTableView.reloadData()
        }
        
        searchController.searchBar.delegate = delegate
        searchController.searchBar.placeholder = "Buscar"
        searchController.searchBar.barTintColor = .white
        messageTableView.tableHeaderView = searchController.searchBar
    }
}

