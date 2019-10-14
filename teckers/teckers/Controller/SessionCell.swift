//
//  SessionCell.swift
//  teckers
//
//  Created by Ricardo Granja on 9/2/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class SessionCell: UICollectionViewCell {

    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Info: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Schedule: UILabel!
    @IBOutlet weak var Subject: UILabel!
    @IBOutlet weak var GeneralDirections: UILabel!
    
    func setDateText(text: String) {
        Date.text = text
    }
    
    func setInfoText(text: String) {
        Info.text = text
    }
    
    func setLocationText(text: String) {
        Location.text = text
    }
    
    func setScheduleText(text: String) {
        Schedule.text = text
    }
    
    func setSubjectText(text: String) {
        Subject.text = text
    }
    
    func setGeneralDirectionsText(text: String) {
        GeneralDirections.text = text
    }
}
