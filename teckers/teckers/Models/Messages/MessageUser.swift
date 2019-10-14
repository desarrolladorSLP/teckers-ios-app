//
//  MessageUser.swift
//  
//
//  Created by Maggie Mendez on 8/30/19.
//

import Foundation

class MessagesUser {
    
    private var messages : [Message]?
    private var infoFriend : User?
    
    init(friend : User){
        self.infoFriend = friend
        messages = []
    }
    
    init(item : [String : Any] , priority : Bool){
        let format = DateFormatter()
        format.dateFormat = MessagesKeys.formatDay.rawValue
        
        guard let userName  = item[ MessagesKeys.sender.rawValue ] as? String,
            let imageUrl = item[ MessagesKeys.senderImage.rawValue ] as? String,
            let subject = item[ MessagesKeys.subject.rawValue ] as? String,
            let time = item[ MessagesKeys.timestamp.rawValue ] as? String,
            let date = format.date(from: time) else{
                return
        }
        
        messages = []
        infoFriend = User(name: userName, imageURL: imageUrl)
        let message = Message(subject: subject, date: date, priority: priority)
        self.setMessages(messages: [message])
    }
    func getInformationFriend() -> User?{
        return infoFriend
    }
    func getMessages() -> [Message]?{
        return messages
    }
    func getLastMessage() -> Message?{
        return messages?.last
    }
    func setMessages(messages : [Message]) {
        self.messages = messages
    }
    
    func addMessage(message : Message) {
        messages?.append(message)
    }
    
    func containsInMessages(text : String) -> [Message]?{
        return messages?.filter { (Message) -> Bool in
            guard let messageContent = Message.text else {
                return false
            }
            return messageContent.lowercased().contains(text.lowercased()) 
        }
    }
    func containsInFriend(text : String) -> Bool{
        if let friend = infoFriend{
            return friend.name.lowercased().contains(text.lowercased())
        }
        return false
    }
    
}
