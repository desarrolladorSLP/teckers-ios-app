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
    private var searchList : [MessagesUser] = []
    private var searching : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        for _ in 1...10{
            messagesList.append(contentsOf: createMessagesUsers())
            messagesList.sort { (message1, message2) -> Bool in
                return message1.getInformationFriend().name < message2.getInformationFriend().name
            }
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
        searchController.searchBar.delegate = self
        
        navigationController?.navigationItem.searchController = searchController
        messageTableView.tableHeaderView = searchController.searchBar
    }
    func setupButton(){
        addMessageButton.backgroundColor = Color.morado
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
        let messages2 = [Message(message:"Bye", date: formattedDate) ]
        user2.setMessages(messages: messages2)
        
        return [user1, user2]
    }
}

extension HomeController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        var message = messagesList[indexPath.row]
        if searching{
            message = searchList[indexPath.row]
        }
        cell.setFriendMessages(friend: message)
        return cell

    }
    
}
extension HomeController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchList.count
        }
        return messagesList.count
    }
}

extension HomeController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchList = messagesList
            messageTableView.reloadData()
            return
        }
        searchList = messagesList.filter({ (message) -> Bool in
            searching = true
            if (message.containsInMessages(text: searchText).count != 0 ) || message.containsInFriend(text: searchText){
                return true
            }
            else{
                return false
            }
        })
        messageTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        messageTableView.reloadData()
    }

}
