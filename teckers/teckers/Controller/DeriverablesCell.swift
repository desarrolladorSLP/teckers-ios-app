//
//  DeriverablesCell.swift
//  teckers
//
//  Created by Ricardo Granja on 16/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DeriverablesCell: UICollectionViewCell {

    @IBOutlet weak var imageDeriverables: UIImageView!
    @IBOutlet weak var titleDeriverables: UILabel!
    let nameCell = "DeriverablesCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
}
