//
//  EventDetailViewController.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import UIKit
import RealmSwift

class EventDetailViewController: UIViewController {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    var event: Event = Event()
    var indexPath = IndexPath()
    var date: Date = Date()
    
    let eventHelper = EventHelper.shared
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = event.name
        descriptionTextView.text = event.descriptionEvent
        dateLabel.text = eventHelper.setDateFormatter(date: date)
        timeLabel.text = eventHelper.initTimeCell(indexPath: indexPath)
    }
    
    @IBAction func saveChange(_ sender: UIBarButtonItem) {
        let isNameTextField = nameTextField.text?.isEmpty
        let isDescriptionTextView = descriptionTextView.text.isEmpty
        let isIdentName = nameTextField.text == event.name
        let isIdentDescription = descriptionTextView.text == event.descriptionEvent
        
        if isNameTextField! || isDescriptionTextView {
            showAlert(title: "Упс", message: "Не все поля заполнены")
            return
        }
        
        if isIdentName && isIdentDescription {
            return
        }
        
        let findEvent = realm.objects(Event.self).filter("id = '\(self.event.id)'").first
        
        if let findEvent = findEvent {
            updateEvent(event: findEvent)
        } else {
            saveEvent()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func updateEvent(event: Event) {
        try! realm.write {
            event.name = nameTextField.text!
            event.descriptionEvent = descriptionTextView.text
        }
    }
    
    private func saveEvent() {
        let event: Event = Event()
        event.name = nameTextField.text!
        event.descriptionEvent = descriptionTextView.text
        event.date_start = Int(date.timeIntervalSince1970) + (indexPath.row * 3600)
        event.date_finish = Int(date.timeIntervalSince1970) + ((indexPath.row + 1) * 3600)

        try! realm.write {
            realm.add(event)
        }
    }
}
