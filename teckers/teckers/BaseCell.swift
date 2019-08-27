//
//  BaseCell.swift
//  teckers
//
//  Created by Maggie Mendez on 8/24/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    private var messages : [Message]?
    private var friend : User?
    
    func setFriend(friend : User){
        self.friend = friend
    }
    
    func setMessages(messages : [Message]) {
        self.messages = messages
    }
    
    func addMessage(message : Message) {
        messages?.append(message)
    }
}
