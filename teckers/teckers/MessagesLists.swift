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
    let backendInteraction : Authentication
    init(success : @escaping (_ list : MessagesLists) -> Void ) {
        HighPriorityMessages = []
        LessPriorityMessages = []
        backendInteraction = Authentication()
        self.backendInteraction.backendMessagesRequest  { (response) in
//            self.HighPriorityMessages = self.createHighMessagesUsers()
//            self.LessPriorityMessages = self.createLowMessagesUsers()
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
    
    func createHighMessagesUsers() -> [MessagesUser]{
        
        let formattedDate = today()
    
        let user1 = MessagesUser(friend: User(name: "Chris Evans", imageURL: Image.Profile1.rawValue ))
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        let user3 = MessagesUser(friend: User(name: "Robert Downey Jr.", imageURL: Image.Profile3.rawValue ))
        
        let messages = [Message(subject: "Hola", message: "Hola como estas?", date: formattedDate, priority: true) ]
        let messages2 = [Message(subject:"Bye", message: "Nos vemos", date: formattedDate, priority: true) ]
        let messages3 = [Message(subject:"Como estas?", message: "Que tal?", date: formattedDate, priority: true) ]
        
        user1.setMessages(messages: messages3)
        user2.setMessages(messages: messages2)
        user3.setMessages(messages: messages)
        
        return [user1, user2, user3]
    }
    
    func createLowMessagesUsers() -> [MessagesUser]{
        
        let formattedDate = today()
        let mensajes = ["Hola como estas?", "Nos vemos", "Como estas?"]
        let subjects = ["Hola", "Bye", "Que tal?"]
        
        let user1 = MessagesUser(friend: User(name: "Dylan Efron", imageURL: Image.Profile.rawValue ))
        let user3 = MessagesUser(friend: User(name: "Chris Evans", imageURL: Image.Profile1.rawValue ))
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        
        let users = [user1, user2, user3]
        
        for i in 0..<mensajes.count{
            let messages = [Message(subject: subjects[i], message: mensajes[i] , date: formattedDate, priority:  false) ]
            users[i].setMessages(messages: messages)
        }
        
        return [user1, user2, user3]
    }
    
    func readMessages(JSON : [String: Any], priority : Bool){
        let high = JSON["highPriorityMessages"] as? [ Any]
        _ = JSON["lowPriorityMessages"] as? [Any]
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
        
        for listItem  in List {
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
