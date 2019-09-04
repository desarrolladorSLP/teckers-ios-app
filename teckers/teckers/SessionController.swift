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
    @IBOutlet weak var Sessions: UICollectionView!
    
    private var daysOfMonth: [Int] = [31,28,31,30,31,30,31,31,30,31,30,31]
    private var dayCurrent = -1
    private var monthCurrent = -1
    private var yearCurrent = -1
    private var weekdayCurrent = -1
    private var startOfMonth = -1
    private var endOfMonth = -1
    private var daySession = -1
    var sessionsValue = 5
    
    let dics = [["date":"2019-9-4", "localization":"Plaza Fundadores","schedule":"9:00 to 12:00","subject":"","generalDirections":"Ninguno"]]
    
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
        daySession = dayCurrent
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
        sessionsValue = 0
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        calculateSpecificDate(monthCurrent, yearCurrent)
        Sessions.reloadData()
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
        sessionsValue = 0
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        calculateSpecificDate(monthCurrent, yearCurrent)
        Calendar.reloadData()
        Sessions.reloadData()
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
    
    func compareDates() -> [String:String] {
        for d in dics {
            if (d["date"] == String("\(yearCurrent)-\(monthCurrent)-\(daySession)")) {
                return d
            }
        }
        
        return [:]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == Sessions) {
            return sessionsValue
        }


        return daysOfMonth[monthCurrent - 1] + startOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == Sessions) {
            let session = collectionView.dequeueReusableCell(withReuseIdentifier: "SessionCurrent", for: indexPath) as! SessionCell
            session.backgroundColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            let d = compareDates()
            if (d == [:]) {
                sessionsValue = 0
            }
            else {
                session.Date.text = d["date"]
                session.Localization.text = d["localization"]
                session.Schedule.text = d["schedule"]
                session.Subject.text = d["subject"]
                session.GeneralDirections.text = d["generalDirections"]
            }
            return session
        }
        let day = collectionView.dequeueReusableCell(withReuseIdentifier: "Day", for: indexPath) as! DayCell

        if ((indexPath.row + 1) > (startOfMonth - 1)) {
            day.labelDay.text = "\(indexPath.row + 1 - startOfMonth + 1)"
            if ((indexPath.row + 1  - startOfMonth + 1) == dayCurrent && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                day.backgroundColor = UIColor.purple
                day.labelDay.textColor = UIColor.white
            }
            else {
                day.backgroundColor = UIColor.clear
                day.labelDay.textColor = UIColor.black
            }
        }
        else {
            day.backgroundColor = UIColor.clear
            day.labelDay.text = ""
        }
        day.layer.borderColor = UIColor.clear.cgColor

        return day
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == Sessions) {
            let alertNotification = Alert(title: "Asistencia", massage: "¿Asistirá a esta sesión?", type: 1)
            present(alertNotification.show(), animated: true, completion: nil)
        }
        else if (collectionView == Calendar) {
            let day = Calendar.cellForItem(at: indexPath)

            if ((indexPath.row + 1) > (startOfMonth - 1)) {
                if ((indexPath.row + 1  - startOfMonth + 1) == dayCurrent && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                    day?.layer.borderColor = UIColor.black.cgColor
                }
                else {
                    day?.layer.borderColor = UIColor.purple.cgColor
                }
                day?.layer.borderWidth = 2
                day?.isSelected = true
                daySession = indexPath.row + 1 - startOfMonth + 1
                print("\(daySession)-\(monthCurrent)-\(yearCurrent)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (collectionView == Sessions) {
            let day = Sessions.cellForItem(at: indexPath)
            day?.layer.borderColor = UIColor.clear.cgColor
            day?.isSelected = false
        }
        let day = Calendar.cellForItem(at: indexPath)
        day?.layer.borderColor = UIColor.clear.cgColor
        day?.isSelected = false
    }
}
