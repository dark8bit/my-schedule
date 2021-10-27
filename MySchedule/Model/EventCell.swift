//
//  EventCell.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 27.10.2021.
//
import Foundation

struct EventCell {
    var id: String = UUID().uuidString
    var name: String = ""
    var date_start: Int = Int(Date().timeIntervalSince1970 * 1000)
    var date_finish: Int = Int(Date().timeIntervalSince1970 * 1000)
    var description: String?
}
