//
//  BaseCell.swift
//  teckers
//
//  Created by Maggie Mendez on 8/24/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var hourLastMessageLabel: UILabel!
    
    private var friendMessage : MessagesUser?{
        didSet{
            if let cacheImage = cache.object(forKey: "image default") {
                userImageView.image = cacheImage
                return
            }
            imageUser = UIImage(named: Image.perfilImageDefault.rawValue)
            if let img = imageUser{
                self.cache.setObject(img, forKey: "image default")
            }
        }
    }
    var NameCell : String { get { return "MessageCell" } }
    var nibName : UINib { return UINib(nibName: self.NameCell, bundle: nil) }
    private let cache = NSCache<NSString, UIImage>()
    private var imgDefault : UIImage?
    private var imageUser : UIImage? {
        didSet{
            DispatchQueue.main.async {
                self.userImageView.image = self.imageUser
            }
        }
    }
    
    func setFriendMessages(friend : MessagesUser, onFailure failure : @escaping (Error) -> Void){
        friendMessage = friend
        
        if let userFriend = friend.getInformationFriend(){
            downloadImage(urlString: userFriend.imageURL, onFailure: failure)
            let format = DateFormatter()
            format.dateFormat = "dd-MM-yy"
            userImageView.layer.cornerRadius = userImageView.frame.height / 2
            nameUserLabel.text = userFriend.name
            if let lastMessage = friendMessage?.getLastMessage(){
                lastMessageLabel.text = lastMessage.subject
                hourLastMessageLabel.text = format.string(from: lastMessage.date)
            }
        }
    }
    func downloadImage(urlString : String, onFailure failure : @escaping (Error) -> Void ) {
        if let cacheImage = cache.object(forKey: urlString as NSString) {
            userImageView.image = cacheImage
            return
        }
        guard let url = URL(string: urlString) else { return }
        requestImage(url: url) { [weak self] (data, error) in
            if let error = error{
                failure(error)
                return
            }
            guard let data = data, let view = self else {
                return
            }
            view.imageUser = UIImage(data: data)
            if let img = view.imageUser {
                view.cache.setObject(img ,forKey: url.absoluteString as NSString)
            }
        }
    }
    func requestImage(url : URL, completionHandler: @escaping (Data?,Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, error)
        }.resume()
    }
}
