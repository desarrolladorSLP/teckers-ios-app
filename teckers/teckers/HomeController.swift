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
    
    private var messagesList : [MessagesUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        for _ in 1...10{
            messagesList.append(contentsOf: createMessagesUsers())
        }
    }
    
    func setupUI() {
        setupTableView()
        setupButton()
        setupNavigateBar()
    }
    func setupTableView(){
        messageTableView.delegate = self
        messageTableView.dataSource = self
        let nibName = UINib(nibName: "BaseCell", bundle: nil)
        messageTableView.register(nibName, forCellReuseIdentifier: "MessageCell")
    }
    func setupNavigateBar(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationController?.navigationItem.searchController = searchController
        messageTableView.tableHeaderView = searchController.searchBar
    }
    func setupButton(){
        addMessageButton.backgroundColor = .purple
        addMessageButton.layer.cornerRadius = addMessageButton.frame.height / 2
        addMessageButton.tintColor = .white
    }
    
    func createMessagesUsers() -> [MessagesUser]{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd"
        let formattedDate = format.string(from: now)
        
        print(formattedDate)
        
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day)
        let user1 = MessagesUser(friend: User(name: "Chris Evans", imageURL: Image.Profile1.rawValue ))
        let messages = [Message(message: "Hola", date: formattedDate) ]
        user1.setMessages(messages: messages)
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        let messages2 = [Message(message: "Ya bye", date: formattedDate) ]
        user2.setMessages(messages: messages2)
        
        return [user1, user2]
    }
}

extension HomeController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messagesList[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let messageCell = cell
        messageCell.setFriendMessages(friend: message)
        return cell

    }
    
}
extension HomeController : UITableViewDelegate{
    
}
