//
//  HighPriorityTableView.swift
//  
//
//  Created by Maggie Mendez on 9/4/19.
//

import UIKit

class MessagesTableViewDelegate: NSObject ,  UITableViewDelegate {
    var fail : ((Error) -> Void)?
    private var messagesList : [MessagesUser]?
    override init() {
        super.init()
    }
}
extension MessagesTableViewDelegate : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = MessageCell(style: .default, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCell.NameCell , for: indexPath) as! MessageCell
        
        if let message = messagesList?[indexPath.row]{
            cell.setFriendMessages(friend: message){[weak self] error in
                if let fail = self?.fail{
                    fail(error)
                }
            }
        }
        return cell
    }
    
}

