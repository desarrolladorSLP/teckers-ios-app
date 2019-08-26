//
//  SessionController.swift
//  teckers
//
//  Created by Ricardo Granja on 8/26/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class SessionController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    var currentMonth:(month: Int, year: Int) = (0,0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentMonth = calculateCurrentMonth()
        monthLabel.text = String(currentMonth.month)
    }
    
    private func calculateCurrentMonth() -> (month: Int, year: Int) {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return (month, year)
    }
    
    @IBAction func backMonth(_ sender: Any) {
        //currentMonth -= 1
    }
    
    @IBAction func afterMonth(_ sender: Any) {
        //currentMonth += 1
    }
    
    private func changeMonthLabel() {
        
    }
    
    private func calculateDate(idMonth: Int) {
        var month: String = ""
    }
}
