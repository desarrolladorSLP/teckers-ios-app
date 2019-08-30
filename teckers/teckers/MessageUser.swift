//
//  MessageUser.swift
//  
//
//  Created by Maggie Mendez on 8/30/19.
//

import Foundation

class MessagesUser{
    
    private var messages : [Message]
    private var infoFriend : User
    
    init(friend : User){
        self.infoFriend = friend
        messages = []
    }
    
    func getInformationFriend() -> User{
        return infoFriend
    }
    func getMessages() -> [Message]{
        return messages
    }
    func getLastMessage() -> Message?{
        return messages.last
    }
    func setMessages(messages : [Message]) {
        self.messages = messages
    }
    
    func addMessage(message : Message) {
        messages.append(message)
    }
    
}
