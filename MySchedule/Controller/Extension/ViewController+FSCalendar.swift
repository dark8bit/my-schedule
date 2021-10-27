//
//  ViewController+FSCalendar.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 27.10.2021.
//

import UIKit
import FSCalendar

// MARK: FSCalendar
extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        isSelectedDate = true
       
        infoView.isHidden = isSelectedDate
        tableView.isHidden = !isSelectedDate
        
        getEventsSelectDate()
        
        isSelectedDate = false
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = eventHelper.setDateFormatter(date: date)
        let eventDate = filterEventsDate(selectDate: dateString)
        
        if eventDate.count > 0 {
            cell.eventIndicator.isHidden = false
            cell.eventIndicator.color = UIColor.blue
            
            cell.eventIndicator.numberOfEvents = eventDate.count
            cell.numberOfEvents = eventDate.count
        }
    }
    
    public func getEventsSelectDate() {
        let selectDate = eventHelper.setDateFormatter(date: selectedDate)
     
        filterEventsForCalendar(selectDate: selectDate)
    }
    
    private func filterEventsForCalendar(selectDate: String) {
        eventsOfSelectedDay = filterEventsDate(selectDate: selectDate)
        tableView.reloadData()
    }
    
    private func filterEventsDate(selectDate: String) -> [Event] {
        let eventList = events.filter({
            let date = Date(timeIntervalSince1970: TimeInterval($0.date_start))
            
            return self.eventHelper.setDateFormatter(date: date) == selectDate
        })
        
        let result = Array(eventList)
        
        return result
    }

}
