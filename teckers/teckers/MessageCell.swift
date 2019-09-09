//
//  BaseCell.swift
//  teckers
//
//  Created by Maggie Mendez on 8/24/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var hourLastMessageLabel: UILabel!
    
    private var friendMessage : MessagesUser?
    
    static var nibName = UINib(nibName: "MessageCell", bundle: nil)
    
    func setFriendMessages(friend : MessagesUser){
        friendMessage = friend
        let userFriend = friend.getInformationFriend()
        if let urlImage = URL(string: userFriend.imageURL){
            do{
                let data = try Data(contentsOf: urlImage )
                imageUser.image = UIImage(data: data)
            }
            catch{
                print("Error \(error.localizedDescription)")
            }
        }
        imageUser.layer.cornerRadius = imageUser.frame.height / 2
        nameUserLabel.text = userFriend.name
        if let lastMessage = friendMessage?.getLastMessage(){
            lastMessageLabel.text = lastMessage.text
            hourLastMessageLabel.text = lastMessage.date
        }
    }
}
