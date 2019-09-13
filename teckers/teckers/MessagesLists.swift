//
//  MessagesLists.swift
//  teckers
//
//  Created by Maggie Mendez on 9/8/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class MessagesLists {
    var HighPriorityMessages : [MessagesUser]
    var LessPriorityMessages : [MessagesUser]
    
    var ListMessages : [MessagesUser]
    private let backendInteraction : Authentication
    init(success : @escaping (_ list : [MessagesUser]) -> Void, priority : Bool ) {
        ListMessages = []
        HighPriorityMessages = []
        LessPriorityMessages = []
        backendInteraction = Authentication()
        
        self.backendInteraction.backendMessagesRequest  { (response) in
            self.readMessages(JSON: response, priority: priority)
//            self.readMessages(JSON: response, priority: false)
            success(self.ListMessages)
        }
    }
    func readMessages(JSON : [String: Any], priority : Bool){
        let listJSON :  [Any]?
        if priority{
            listJSON = JSON[MessagesKeys.highPriority.rawValue] as? [ Any]
        }
        else {
            listJSON = JSON[MessagesKeys.lowPriority.rawValue] as? [Any]
        }
        guard let List = listJSON else{
           return
        }
        pullAllMessagesOf(priority: priority, in: List)
    }
    
    func pullAllMessagesOf(priority: Bool, in list: [Any]){
        for listItem  in list {
            if let item = listItem as? [String : Any] {
                if let userMessages = createMessage(item: item, priority: true){
                    ListMessages.append(userMessages)
                }
            }
        }
    }
    func createMessage(item : [String : Any] , priority : Bool) -> MessagesUser?{
        let format = DateFormatter()
        format.dateFormat = MessagesKeys.formatDay.rawValue
        
        guard let userName  = item[ MessagesKeys.sender.rawValue ] as? String,
        let imageUrl = item[ MessagesKeys.senderImage.rawValue ] as? String,
        let subject = item[ MessagesKeys.subject.rawValue ] as? String,
        let time = item[ MessagesKeys.timestamp.rawValue ] as? String,
        let date = format.date(from: time) else{
            return nil
        }
        
        let user = User(name: userName, imageURL: imageUrl)
        let message = Message(subject: subject, date: date, priority: priority)
        let userMessage : MessagesUser =  MessagesUser(friend: user)
        userMessage.setMessages(messages: [message])
        
        return userMessage
    }
}
