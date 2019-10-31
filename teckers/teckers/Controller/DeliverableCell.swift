//
//  2ndTableViewCell.swift
//  teckersDeliverable
//
//  Created by Maggie Mendez on 10/8/19.
//  Copyright © 2019 Maggie Mendez. All rights reserved.
//

import UIKit

class DeliverableCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var leftTitleLabel: UILabel!
    
    @IBOutlet weak var rightDateLabel: UILabel!
    @IBOutlet weak var leftDateLabel: UILabel!
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy"
        return formatter
    }
    
    var deliverable: Deliverable? {
        didSet{
            if type == .right{
                useRightText()
            }
            else {
                useLeftText()
            }
        }
    }
    
    var status: statusDeliverables = .none {
        didSet{
            var color: UIColor
            var image: imageDeliverables = .circle
            switch self.status {
            case .accepted:
                image = .check
                fallthrough
            case .readyForReview:
                color = .systemGreen
            case .blocked:
                color = .red
                image = .blocked
            case .rejected:
                color = .red
                image = .cross
            case .overdue:
                color = .red
            case .inProgress:
                color = .systemYellow
            default:
                color = .black
            }
            if #available(iOS 13.0, *) {
                statusImage.image = UIImage(systemName: image.rawValue)
            } else {
                statusImage.image = UIImage(named: image.rawValue)
            }
            statusImage.tintColor = color
        }
    }
    
    var type: textDeliverableDireccion = .right {
        willSet(newValue){
            if newValue != .right{
                leftTitleLabel.isHidden = false
                leftDateLabel.isHidden = false
                rightTitleLabel.isHidden = true
                rightDateLabel.isHidden = true
            }
            else {
                leftTitleLabel.isHidden = true
                leftDateLabel.isHidden = true
                rightTitleLabel.isHidden = false
                rightDateLabel.isHidden = false
            }

        }
    }
    
    func useRightText(){
        rightTitleLabel.text = deliverable?.title
        rightDateLabel.text = dateFormatter.string(from: deliverable?.date ?? Date())
    }
    func useLeftText(){
        leftTitleLabel.text = deliverable?.title
        leftDateLabel.text = dateFormatter.string(from: deliverable?.date ?? Date())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        statusImage.layer.cornerRadius = statusImage.frame.height / 2
        setup()
    }

    func setup(){
        leftTitleLabel.isHidden = true
        leftDateLabel.isHidden = true
        status = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
