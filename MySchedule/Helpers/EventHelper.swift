//
//  EventHelper.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import Foundation

final class EventHelper: NSObject {
    static let shared = EventHelper()
    
    private override init() {}
    
    public func initTimeCell(indexPath: IndexPath) -> String {
        let cell = indexPath.row
        
        let startTime = cell > 9 ? "\(cell)" : "0\(cell)"
        let endTime = cell + 1 > 9 ? "\(cell + 1)" : "0\(cell + 1)"
        
        return "\(startTime):00-\(endTime):00"
    }
    
    public func setDateFormatter(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        return dateFormatterGet.string(from: date)
    }
    
    public func getHour(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH"

        return dateFormatterGet.string(from: date)
    }
}
