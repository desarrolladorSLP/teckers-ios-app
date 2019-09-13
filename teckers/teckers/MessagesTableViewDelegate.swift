//
//  HighPriorityTableView.swift
//  Alamofire
//
//  Created by Maggie Mendez on 9/4/19.
//

import UIKit

class MessagesTableViewDelegate: NSObject ,  UITableViewDelegate {

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
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.NameCell, for: indexPath) as! MessageCell
        
        if let message = messagesList?[indexPath.row]{
            cell.setFriendMessages(friend: message)
        }
        return cell
    }
}

