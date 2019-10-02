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
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var sessionCollectionView: UICollectionView!
    
    private var daysOfMonth: [Int] = []
    
    private var dayCurrent = DateCalendar.calculateCurrentDay()
    private var monthCurrent = DateCalendar.calculateCurrentMonth()
    private var yearCurrent = DateCalendar.calculateCurrentYear()
    private var weekdayCurrent = DateCalendar.calculateCurrentWeekday()
    
    private var startOfMonth = -1
    private var endOfMonth = -1
    private var sessionsValue = -1
    private var allSessions:[Session] = []
    private var sessionsForDate:[Session] = []
    private var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        Session.backendSessionsRequest(year: yearCurrent, month: monthCurrent, success: { [weak self] (response) in
            for dictionarySession in response {
                self?.allSessions.append(Session(JSON: dictionarySession))
            }
            self?.sessionsValue = self?.allSessions.count ?? 0
            self?.sessionsForDate = self!.allSessions
            self?.calendarCollectionView.reloadData()
            }, failure: { [weak self] Error in
                let alertAction = Alert(title: "Error", massage: Error.localizedDescription, type: 0)
                self?.present(alertAction.show(), animated: true, completion: nil)
        })
        sessionsForDate = allSessions
        daysOfMonth = DateCalendar.daysOfMonthsByYear(yearCurrent)
        startOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
        endOfMonth = DateCalendar.calculateSpecificEndOfMonth(monthCurrent, yearCurrent, daysOfMonth[monthCurrent - 1])
    }
    
    @IBAction func backMonth(_ sender: Any) {
        allSessions = []
        sessionsForDate = []
        sessionsValue = 0
        if (monthCurrent == 1) {
            monthCurrent = 12
            yearCurrent -= 1
            startOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
            endOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
            daysOfMonth = DateCalendar.daysOfMonthsByYear(yearCurrent)
        } else {
            monthCurrent -= 1
        }
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        startOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
        endOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
        Session.backendSessionsRequest(year: yearCurrent, month: monthCurrent, success: { [weak self] (response) in
            for dictionarySession in response {
                self?.allSessions.append(Session(JSON: dictionarySession))
            }
            self?.sessionsValue = self?.allSessions.count ?? 0
            self?.sessionsForDate = self!.allSessions
            self?.calendarCollectionView.reloadData()
            }, failure: { [weak self] Error in
                let alertAction = Alert(title: "Error", massage: Error.localizedDescription, type: 0)
                self?.present(alertAction.show(), animated: true, completion: nil)
        })
        dayCurrent = 0
        sessionCollectionView.reloadData()
    }
    
    @IBAction func afterMonth(_ sender: Any) {
        allSessions = []
        sessionsForDate = []
        sessionsValue = 0
        if (monthCurrent == 12) {
            monthCurrent = 1
            yearCurrent += 1
            startOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
            endOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
            daysOfMonth = DateCalendar.daysOfMonthsByYear(yearCurrent)
        } else {
            monthCurrent += 1
        }
        monthLabel.text = changeDateLabel(monthCurrent, yearCurrent)
        startOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
        endOfMonth = DateCalendar.calculateSpecificStartOfMonth(monthCurrent, yearCurrent)
        Session.backendSessionsRequest(year: yearCurrent, month: monthCurrent, success: { [weak self] (response) in
            for dictionarySession in response {
                self?.allSessions.append(Session(JSON: dictionarySession))
            }
            self?.sessionsValue = self?.allSessions.count ?? 0
            self?.sessionsForDate = self!.allSessions
            self?.calendarCollectionView.reloadData()
            }, failure: { [weak self] Error in
                let alertAction = Alert(title: "Error", massage: Error.localizedDescription, type: 0)
                self?.present(alertAction.show(), animated: true, completion: nil)
        })
        dayCurrent = 0
        sessionCollectionView.reloadData()
    }
    
    private func changeDateLabel(_ month: Int,_ year: Int) -> String {
        
        switch month - 1 {
        case Month.Enero.rawValue:
            return "\(Month.Enero), \(yearCurrent)"
        case Month.Febrero.rawValue:
            return "\(Month.Febrero), \(yearCurrent)"
        case Month.Marzo.rawValue:
            return "\(Month.Marzo), \(yearCurrent)"
        case Month.Abril.rawValue:
            return "\(Month.Abril), \(yearCurrent)"
        case Month.Mayo.rawValue:
            return "\(Month.Mayo), \(yearCurrent)"
        case Month.Junio.rawValue:
            return "\(Month.Junio), \(yearCurrent)"
        case Month.Julio.rawValue:
            return "\(Month.Julio), \(yearCurrent)"
        case Month.Agosto.rawValue:
            return "\(Month.Agosto), \(yearCurrent)"
        case Month.Septiembre.rawValue:
            return "\(Month.Septiembre), \(yearCurrent)"
        case Month.Octubre.rawValue:
            return "\(Month.Octubre), \(yearCurrent)"
        case Month.Noviembre.rawValue:
            return "\(Month.Noviembre), \(yearCurrent)"
        case Month.Diciembre.rawValue:
            return "\(Month.Diciembre), \(yearCurrent)"
        default:
            return ""
        }
    }
}

extension SessionController: UICollectionViewDelegate {
    
}

extension SessionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == sessionCollectionView) {
            return sessionsValue
        }
        
        return daysOfMonth[monthCurrent - 1] + startOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == sessionCollectionView) {
            let session = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.SessionCell.rawValue, for: indexPath) as! SessionCell
            if (sessionsForDate.count > 0) {
                let dateSession = DateCalendar.datetoString(sessionsForDate[indexPath.row].date)
                let dateCurrent = "\(DateCalendar.left(num: String(dayCurrent), total: 2, cadena: "0"))-\(DateCalendar.left(num: String(monthCurrent), total: 2, cadena: "0"))-\(yearCurrent)"
                
                if (dateSession == dateCurrent) {
                    session.layer.borderColor = UIColor(red: 93/255, green: 92/255, blue: 160/255, alpha: 1).cgColor
                    session.layer.borderWidth = 2
                    session.setDateText(text: "Sesión el día \(DateCalendar.datetoString(sessionsForDate[indexPath.row].date))")
                    session.setInfoText(text: "INFORMACIÓN:")
                    session.setLocationText(text: "Ubicación: \(sessionsForDate[indexPath.row].location)")
                    session.setScheduleText(text: "Horario de \(DateCalendar.timeToString(sessionsForDate[indexPath.row].startTime)) a \(DateCalendar.timeToString(sessionsForDate[indexPath.row].endTime))")
                    session.setSubjectText(text: "Temas a tratar: \(sessionsForDate[indexPath.row].subject)")
                    session.setGeneralDirectionsText(text: "Indicacíones generales: \(String(describing: sessionsForDate[indexPath.row].directions))")
                }
            }
            else {
                session.setDateText(text: "")
                session.setInfoText(text: "")
                session.setLocationText(text: "")
                session.setScheduleText(text: "")
                session.setSubjectText(text: "")
                session.setGeneralDirectionsText(text: "")
            }
            
            return session
        }
        let day = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.DayCell.rawValue, for: indexPath) as! DayCell
        
        if ((indexPath.row + 1) > (startOfMonth - 1)) {
            day.labelDay.text = "\(indexPath.row + 1 - startOfMonth + 1)"
            day.viewDay.backgroundColor = UIColor.clear
            if ((indexPath.row + 1  - startOfMonth + 1) == NSCalendar.current.component(.day, from: Date()) && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                day.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 160/255, alpha: 1)
                day.labelDay.textColor = UIColor.white
            }
            else {
                day.backgroundColor = UIColor.clear
                day.labelDay.textColor = UIColor.black
            }
            if (sessionsValue > 0) {
                let dateCurrent = "\(DateCalendar.left(num: String(indexPath.row + 1 - startOfMonth + 1), total: 2, cadena: "0"))-\(DateCalendar.left(num: String(monthCurrent), total: 2, cadena: "0"))-\(yearCurrent)"
                for dictionarySession in sessionsForDate {
                    let dateSession = DateCalendar.datetoString(dictionarySession.date)
                    if (dateSession == dateCurrent) {
                        if ((indexPath.row + 1  - startOfMonth + 1) == NSCalendar.current.component(.day, from: Date()) && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                            day.viewDay.backgroundColor = UIColor.yellow
                        }
                        else {
                            day.viewDay.backgroundColor = UIColor(red: 93/255, green: 92/255, blue: 160/255, alpha: 1)
                        }
                    }
                }
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
        if (collectionView == sessionCollectionView) {
            let dateSession = DateCalendar.datetoString(sessionsForDate[indexPath.row].date)
            let dateCurrent = "\(DateCalendar.left(num: String(dayCurrent), total: 2, cadena: "0"))-\(DateCalendar.left(num: String(monthCurrent), total: 2, cadena: "0"))-\(yearCurrent)"
            
            if (dateSession == dateCurrent && allSessions.count > 0) {
                let alertNotification = Alert(title: "Asistencia", massage: "¿Asistirá a esta sesión?", type: 1)
                present(alertNotification.show(), animated: true, completion: nil)
            }
        }
        else if (collectionView == calendarCollectionView) {
            let day = calendarCollectionView.cellForItem(at: indexPath)
            
            if ((indexPath.row + 1) > (startOfMonth - 1)) {
                if ((indexPath.row + 1  - startOfMonth + 1) == NSCalendar.current.component(.day, from: Date()) && monthCurrent == NSCalendar.current.component(.month, from: Date()) && yearCurrent == NSCalendar.current.component(.year, from: Date())) {
                    day?.layer.borderColor = UIColor.black.cgColor
                }
                else {
                    day?.layer.borderColor = UIColor(red: 93/255, green: 92/255, blue: 160/255, alpha: 1).cgColor
                }
                day?.layer.borderWidth = 2
                day?.isSelected = true
                
                dayCurrent = indexPath.row + 1 - startOfMonth + 1
                sessionsForDate = []
                let dateCurrent = "\(DateCalendar.left(num: String(dayCurrent), total: 2, cadena: "0"))-\(DateCalendar.left(num: String(monthCurrent), total: 2, cadena: "0"))-\(yearCurrent)"
                for dictionarySession in allSessions {
                    let dateSelected = DateCalendar.datetoString(dictionarySession.date)
                    if dateSelected == dateCurrent {
                        sessionsForDate.append(dictionarySession)
                    }
                }
                sessionsValue = sessionsForDate.count
                sessionCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (collectionView == sessionCollectionView) {
            let day = sessionCollectionView.cellForItem(at: indexPath)
            day?.layer.borderColor = UIColor.clear.cgColor
            day?.isSelected = false
        }
        let day = calendarCollectionView.cellForItem(at: indexPath)
        day?.layer.borderColor = UIColor.clear.cgColor
        day?.isSelected = false
    }
}
