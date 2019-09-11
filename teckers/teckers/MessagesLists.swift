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
    private let backendInteraction : Authentication
    init(success : @escaping (_ list : MessagesLists) -> Void ) {
        HighPriorityMessages = []
        LessPriorityMessages = []
        backendInteraction = Authentication()
        self.backendInteraction.backendMessagesRequest  { (response) in
            self.readMessages(JSON: response, priority: true)
            self.readMessages(JSON: response, priority: false)
            success(self)
        }
    }
    
    func today() -> String{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd"
        let formattedDate = format.string(from: now)
        return formattedDate
    }
    
    func readMessages(JSON : [String: Any], priority : Bool){
        let listJSON :  [Any]?
        if priority{
            listJSON = JSON["highPriorityMessages"] as? [ Any]
        }
        else {
            listJSON = JSON["lowPriorityMessages"] as? [Any]
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
                    if priority{
                        HighPriorityMessages.append(userMessages)
                    }
                    else{
                        LessPriorityMessages.append(userMessages)
                    }
                }
            }
        }
    }
    func createMessage(item : [String : Any] , priority : Bool) -> MessagesUser?{
        let userName  = item["sender"] as? String ?? "nil"
        let imageUrl = item["senderImage"] as? String ?? "nil"
        let subject = item["subject"] as? String ?? "nil"
        let body = item["body"] as? String ?? "nil"
        let time = item["timestamp"] as? String ?? "1999-10-19 10:23:54"
        
        let user = User(name: userName, imageURL: imageUrl)
        let message = Message(subject: subject, message: body, date: time, priority: priority)
        let userMessage : MessagesUser =  MessagesUser(friend: user)
        userMessage.setMessages(messages: [message])
        
        return userMessage
    }
}
