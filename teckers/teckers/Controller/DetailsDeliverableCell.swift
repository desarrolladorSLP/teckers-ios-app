//
//  DetailsDeliverableCell.swift
//  teckers
//
//  Created by Maggie Mendez on 21/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class DetailsDeliverableCell: UITableViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setup(_ type: detailsTypeCell,_ item: String ){
        
        switch type {
            case .title:
                valueLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
                valueLabel.text = item
            case .description:
                if #available(iOS 13.0, *) {
                    viewBackground.backgroundColor = .systemGray6
                } else {
                    viewBackground.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
                }
                valueLabel.text = item                
            default:
                valueLabel.text = item
        }
    }
}

