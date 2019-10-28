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
<<<<<<< HEAD
    var mainRect: CGRect?
    override func awakeFromNib() {
        super.awakeFromNib()
        imageDeriverables.image = UIImage(named: Image.perfilImageDefault.rawValue)
        
        self.imageDeriverables.layer.cornerRadius = self.imageDeriverables.frame.height / 2
        self.imageDeriverables.layer.masksToBounds = true
        mainRect = CGRect(x: 0, y: 0, width: self.imageDeriverables.frame.width, height: self.imageDeriverables.frame.height)
        DispatchQueue.main.async { [weak self] in
            if let rect = self?.mainRect{
                let render = UIGraphicsImageRenderer(size: rect.size )
                self?.imageDeriverables.image = render.image(actions: { (context) in
                    context.fill(rect)
                    self?.imageDeriverables.draw(rect)
                })
            }
        }
=======
    
    override func awakeFromNib() {
        super.awakeFromNib()
>>>>>>> Role Definition
        // Initialization code
    }
    
    static func downloadImage(urlString: String, completion: @escaping (Data?,Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkHandler.requestImage(url: url, completionHandler: { data, error in
            if let Error = error {
                completion(nil, Error)
            }
            else if let Data = data {
                completion(Data, nil)
            }
        })
    }
    
    func commitInit(data: Data, name: String) {
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
<<<<<<< HEAD
    func commitInit(name: String) {
        DispatchQueue.main.async {
            self.titleDeriverables.text = name
        }
    }
=======
>>>>>>> Role Definition
    
}
