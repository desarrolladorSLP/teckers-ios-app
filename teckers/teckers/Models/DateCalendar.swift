//
//  DateCalendar.swift
//  teckers
//
//  Created by Ricardo Granja on 9/26/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class DateCalendar {
    
    static func stringToDate(to: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let date = formatter.date(from: to)
        
        return date ?? Date()
    }
    
    static func datetoString(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDateString = formatter.string(from: date ?? Date())
        
        var fullNameArr = formattedDateString.split(separator: "-").map(String.init)
        var saveAux = ""
        
        saveAux = fullNameArr[0]
        fullNameArr[0] = fullNameArr[2]
        fullNameArr[2] = saveAux
        
        return fullNameArr[0] + "-" + fullNameArr[1] + "-" + fullNameArr[2]
    }
    
    static func stringToTime(to: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let date = formatter.date(from: to)
        
        return date ?? Date()
    }
    
    static func timeToString(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let formattedDateString = formatter.string(from: date ?? Date())
        
        let fullNameArr = formattedDateString.split(separator: "-").map(String.init)
        let time = fullNameArr[0]
        
        return time
    }
    
    static func left(num: String, total:Int, cadena: String) -> String {
        let pad = total - num.count;
        return pad < 1 ? num : "".padding(toLength: pad, withPad: cadena, startingAt: 0) + num
    }
    
    static func calculateCurrentDay() -> Int {
        return NSCalendar.current.component(.day, from: Date())
    }
    
    static func calculateCurrentMonth() -> Int {
        return NSCalendar.current.component(.month, from: Date())
    }
    
    static func calculateCurrentYear() -> Int {
        return NSCalendar.current.component(.year, from: Date())
    }
    
    static func calculateCurrentWeekday() -> Int {
        return NSCalendar.current.component(.weekday, from: Date())
    }
    
    static func daysOfMonthsByYear(_ year: Int) -> [Int] {
        let leapYear: Bool = year % 4 == 0 && (year % 100) > 0 || year % 400 == 0
        var daysOfMonth: [Int] = [31,28,31,30,31,30,31,31,30,31,30,31]
        
        if (leapYear) {
            daysOfMonth[1] = 29
        }
        
        return daysOfMonth
    }
    
    static func calculateSpecificStartOfMonth(_ month: Int,_ year: Int) -> Int {
        let specificDate = DateComponents(year: year, month: month, day: 1)
        let componentsSpecific = NSCalendar.current.dateComponents([.weekday], from: NSCalendar.current.date(from: specificDate)!)
        
        return componentsSpecific.weekday ?? 0
    }
    
    static func calculateSpecificEndOfMonth(_ month: Int,_ year: Int, _ daysOfMonth: Int) -> Int {
        let specificDate = DateComponents(year: year, month: month, day: daysOfMonth)
        let componentsSpecific = NSCalendar.current.dateComponents([.weekday], from: NSCalendar.current.date(from: specificDate)!)
        
        return componentsSpecific.weekday ?? 0
    }
}
