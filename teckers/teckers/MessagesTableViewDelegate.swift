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

