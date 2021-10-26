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
}
