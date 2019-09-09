//
//  HighPriorityTableView.swift
//  Alamofire
//
//  Created by Maggie Mendez on 9/4/19.
//

import UIKit

class MessagesTableViewDelegate: NSObject ,  UITableViewDelegate {

    private var messagesList : [MessagesUser]?
//    var reload : () -> Void
    override init() {
        super.init()
        messagesList = []
//        reload = {}
//        reload = success
        for _ in 1...10{
            messagesList?.append(contentsOf: createMessagesUsers())
        }
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
        let messages = [Message(message: "Hola", date: formattedDate, priority: true) ]
        user1.setMessages(messages: messages)
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        let messages2 = [Message(message:"Bye", date: formattedDate, priority: true) ]
        user2.setMessages(messages: messages2)
        
        return [user1, user2]
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
extension MessagesTableViewDelegate : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        if let message = messagesList?[indexPath.row]{
            cell.setFriendMessages(friend: message)
        }
        return cell
    }
}

