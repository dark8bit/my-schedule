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
    
    @IBOutlet var infoView: UIView! {
        didSet {
            infoView.isHidden = false
        }
    }
    
    var isSelectedDate: Bool = true

    lazy var realm: Realm = {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 6, migrationBlock: nil)
        return try! Realm()
    }()
    
    let eventHelper = EventHelper.shared
    
    var events: Results<Event>!
    var eventsOfSelectedDay: [Event] = [Event]()
    var eventCell = Array(repeating: Event(id: "0",
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
        print(realm.configuration.fileURL!)
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
    
    public func reloadData() {
        calendar.reloadData()
        tableView.reloadData()
    }
}
