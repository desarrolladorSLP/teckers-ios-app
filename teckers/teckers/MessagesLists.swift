//
//  MessagesLists.swift
//  teckers
//
//  Created by Maggie Mendez on 9/8/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct MessagesLists {
    var HighPriorityMessages : [MessagesUser]
    var LessPriorityMessages : [MessagesUser]
    
    init(JSON : [String : Any]) {
        HighPriorityMessages = []
        LessPriorityMessages = []
        
        HighPriorityMessages = createHighMessagesUsers()
    }
    
    func createHighMessagesUsers() -> [MessagesUser]{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd"
        let formattedDate = format.string(from: now)
        
    
        let user1 = MessagesUser(friend: User(name: "Chris Evans", imageURL: Image.Profile1.rawValue ))
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        let user3 = MessagesUser(friend: User(name: "Robert Downey Jr.", imageURL: Image.Profile3.rawValue ))
        
        let messages = [Message(message: "Hola", date: formattedDate, priority:  true) ]
        let messages2 = [Message(message:"Bye", date: formattedDate, priority: true) ]
        let messages3 = [Message(message:"Que tal?", date: formattedDate, priority: true) ]
        
        user1.setMessages(messages: messages3)
        user2.setMessages(messages: messages2)
        user3.setMessages(messages: messages)
        
        return [user1, user2, user3]
    }
    
    func createLowMessagesUsers() -> [MessagesUser]{
        let now = Date()
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd"
        let formattedDate = format.string(from: now)
        
        let mensajes = ["Hola", "Bye", "Que tal?"]
        
        let user1 = MessagesUser(friend: User(name: "Dylan Efron", imageURL: Image.Profile.rawValue ))
        let user3 = MessagesUser(friend: User(name: "Chris Evans", imageURL: Image.Profile1.rawValue ))
        let user2 = MessagesUser(friend: User(name: "Zac Efron", imageURL: Image.Profile2.rawValue ))
        
        let users = [user1, user2, user3]
        
        for i in 0..<mensajes.count{
            let messages = [Message(message: mensajes[i] , date: formattedDate, priority:  false) ]
            users[i].setMessages(messages: messages)
        }
        
        return [user1, user2, user3]
    }
    
}
