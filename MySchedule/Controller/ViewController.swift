//
//  ViewController.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import UIKit
import FSCalendar
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
        }
    }
    @IBOutlet var plusButton: UIButton! {
        didSet {
            plusButton.layer.cornerRadius = plusButton.bounds.width / 2
        }
    }
    
    @IBOutlet var infoView: UIView! {
        didSet {
            infoView.isHidden = false
        }
    }
    
    var isSelectedDate: Bool = true

    lazy var realm:Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 6, migrationBlock: nil)
        return try! Realm()
    }()
    
    let eventHelper = EventHelper.shared
    
    var events: Results<Event>!
    var eventsOfSelectedDay: [Event] = [Event]()
    var eventCell = Array(repeating: Event(id: "",
                                          name: "",
                                           descriptionEvent: "", date_start: 0,
                                           date_finish: 0), count: 24)
    let showEventDetailSegueIdentifier = "showEventDetail"
    var selectedDate: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        events = realm.objects(Event.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadData()
        getEventsSelectDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEventDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! EventDetailViewController

                destinationController.indexPath = indexPath
                destinationController.date = selectedDate
                destinationController.event = self.eventCell[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    private func reloadData() {
        calendar.reloadData()
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegeta, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "eventcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventViewCell
        var event = Event()
        
        eventsOfSelectedDay.forEach({
            let hourStart = eventHelper.getHour(date: $0.date_start)

            if Int(hourStart) == indexPath.row {
                event = $0
            }
        })
        
        if !isSelectedDate {
            eventCell[indexPath.row] = event
        }
        
        cell.timeLabel.text = eventHelper.initTimeCell(indexPath: indexPath)
        cell.nameLabel.text = event.name.count > 0 ? event.name : "Событий нет"
        cell.descriprionLabel.text = event.descriptionEvent.count > 0 ? event.descriptionEvent : "Пусто"

        return cell
    }


    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

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
    
    private func getEventsSelectDate() {
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
