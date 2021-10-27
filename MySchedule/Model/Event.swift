//
//  Event.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import RealmSwift

class Event: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var date_start: Int = 0
    @objc dynamic var date_finish: Int = 0
    @objc dynamic var descriptionEvent: String = ""

    convenience init(id: String,
                     name: String,
                     descriptionEvent: String,
                     date_start: Int,
                     date_finish: Int) {
        self.init()
        self.id = id
        self.name = name
        self.descriptionEvent = descriptionEvent
        self.date_start = date_start
        self.date_finish = date_finish
    }
}
