//
//  DeriverablesCell.swift
//  teckers
//
//  Created by Ricardo Granja on 16/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DeriverablesTeckersCell: UICollectionViewCell {

    @IBOutlet weak var imageDeriverables: UIImageView!
    @IBOutlet weak var titleDeriverables: UILabel!
    static let nameCell = "DeriverablesTeckersCell"
    var tecker: Tecker? {
        didSet{
            self.downloadImage(urlString: tecker?.imageURL ?? "") {[weak self] (data, error) in
                if let data = data{
                    self?.commitInit(with: data, name: self?.tecker?.name ?? "Tecker")
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageDeriverables.image = #imageLiteral(resourceName: "default-user")
        self.titleDeriverables.text = "Tecker"
    }
    
    func downloadImage(urlString: String, completion: @escaping (Data?,Error?) -> Void) {
        let urlStr = "https://cdn2.vectorstock.com/i/1000x1000/26/06/young-executive-woman-profile-icon-vector-9692606.jpg"
        guard let url = URL(string: urlStr) else { return }
        
        NetworkHandler.requestImage(url: url, completionHandler: { data, error in
            if let Error = error {
                completion(nil, Error)
            }
            else if let Data = data {
                completion(Data, nil)
            }
        })
    }
    
    func commitInit(with data: Data, name: String) {
        DispatchQueue.main.async {
            let mainRect = CGRect(x: 0, y: 0, width: self.imageDeriverables.frame.width, height: self.imageDeriverables.frame.height)
            
            self.imageDeriverables.image = UIImage(data: data)
            self.imageDeriverables.layer.cornerRadius = self.imageDeriverables.frame.height / 2
            self.imageDeriverables.layer.masksToBounds = true
            self.titleDeriverables.text = name
            DispatchQueue.main.async {
                let render = UIGraphicsImageRenderer(size: mainRect.size)
                self.imageDeriverables.image = render.image(actions: { (context) in
                    context.fill(mainRect)
                    
                    self.imageDeriverables.draw(mainRect)
                })
            }
        }
    }
    
}
