//
//  SessionController.swift
//  teckers
//
//  Created by Ricardo Granja on 8/26/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class SessionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var Calendar: UICollectionView!
    
    private var daysOfMonth: [Int] = [31,28,31,30,31,30,31,31,30,31,30,31]
    private var dayCurrent = -1
    private var monthCurrent = -1
    private var yearCurrent = -1
    private var weekdayCurrent = -1
    private var startOfMonth = -1
    private var endOfMonth = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculateCurrentDate()
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        
    }
    
    private func calculateCurrentDate() {
        dayCurrent = NSCalendar.current.component(.day, from: Date())
        monthCurrent = NSCalendar.current.component(.month, from: Date())
        yearCurrent = NSCalendar.current.component(.year, from: Date())
        weekdayCurrent = NSCalendar.current.component(.weekday, from: Date())
        daysOfMonth = daysOfMonthsByYear(yearCurrent)
        calculateSpecificDate(monthCurrent, yearCurrent)
    }
    
    private func calculateSpecificDate(_ month: Int,_ year: Int) { //Remember talk with Magui about the function´s name
        var specificDate = DateComponents(year: year, month: month, day: 1)
        var componentsSpecific = NSCalendar.current.dateComponents([.weekday], from: NSCalendar.current.date(from: specificDate)!)
        
        startOfMonth = componentsSpecific.weekday ?? 0
        
        specificDate = DateComponents(year: year, month: month, day: daysOfMonth[monthCurrent - 1])
        componentsSpecific = NSCalendar.current.dateComponents([.weekday], from: NSCalendar.current.date(from: specificDate)!)
        
        endOfMonth = componentsSpecific.weekday ?? 0
    }
    
    private func daysOfMonthsByYear(_ year: Int) -> [Int] {
        let leapYear: Bool = year % 4 == 0 && (year % 100) > 0 || year % 400 == 0
        
        if (leapYear) {
            daysOfMonth[1] = 29
        } else {
            daysOfMonth[1] = 28
        }
        
        return daysOfMonth
    }
    
    @IBAction func backMonth(_ sender: Any) {
        if (monthCurrent == 1) {
            monthCurrent = 12
            yearCurrent -= 1
            calculateSpecificDate(monthCurrent, yearCurrent)
            daysOfMonth = daysOfMonthsByYear(yearCurrent)
        } else {
            monthCurrent -= 1
        }
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        calculateSpecificDate(monthCurrent, yearCurrent)
        Calendar.reloadData()
    }
    
    @IBAction func afterMonth(_ sender: Any) {
        if (monthCurrent == 12) {
            monthCurrent = 1
            yearCurrent += 1
            calculateSpecificDate(monthCurrent, yearCurrent)
            daysOfMonth = daysOfMonthsByYear(yearCurrent)
        } else {
            monthCurrent += 1
        }
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        calculateSpecificDate(monthCurrent, yearCurrent)
        Calendar.reloadData()
    }
    
    private func changeDateLabel(_ month: Int,_ year: Int) -> String {
        var monthOut = ""
        
        switch month {
        case Month.January.rawValue:
            monthOut = "\(Month.January), \(yearCurrent)"
        case Month.February.rawValue:
            monthOut = "\(Month.February), \(yearCurrent)"
        case Month.March.rawValue:
            monthOut = "\(Month.March), \(yearCurrent)"
        case Month.April.rawValue:
            monthOut = "\(Month.April), \(yearCurrent)"
        case Month.May.rawValue:
            monthOut = "\(Month.May), \(yearCurrent)"
        case Month.June.rawValue:
            monthOut = "\(Month.June), \(yearCurrent)"
        case Month.July.rawValue:
            monthOut = "\(Month.July), \(yearCurrent)"
        case Month.August.rawValue:
            monthOut = "\(Month.August), \(yearCurrent)"
        case Month.September.rawValue:
            monthOut = "\(Month.September), \(yearCurrent)"
        case Month.Octuber.rawValue:
            monthOut = "\(Month.Octuber), \(yearCurrent)"
        case Month.November.rawValue:
            monthOut = "\(Month.November), \(yearCurrent)"
        case Month.December.rawValue:
            monthOut = "\(Month.December), \(yearCurrent)"
        default:
            print("")
        }
        
        return monthOut
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfMonth[monthCurrent - 1] + startOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Day", for: indexPath) as! DayCell
        
        if ((indexPath.row + 1) > (startOfMonth - 1)) {
            cell.labelDay.text = "\(indexPath.row + 1 - startOfMonth + 1)"
            if ((indexPath.row + 1  - startOfMonth + 1) == dayCurrent && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                cell.backgroundColor = UIColor.red
                cell.labelDay.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.clear
                cell.labelDay.textColor = UIColor.black
            }
        } else {
            cell.backgroundColor = UIColor.clear
            cell.labelDay.text = ""
        }
        
        return cell
    }
}
