//
//  ViewController.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var plusButton: UIButton! {
        didSet {
            plusButton.layer.cornerRadius = plusButton.bounds.width / 2
        }
    }
    
    let eventHelper = EventHelper.shared
    let evenCell = Array(repeating: Event(id: "0",
                                          name: "",
                                          date_start: 0,
                                          date_finish: 0,
                                          description: ""), count: 24)
    let showEventDetailSegueIdentifier = "showEventDetail"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEventDetailSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! EventDetailViewController
                
                destinationController.time = eventHelper.initTimeCell(indexPath: indexPath)
                destinationController.event = self.evenCell[indexPath.row]
            }
        }
    }
}

// MARK: UITableViewDelegeta, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evenCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "eventcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventViewCell
        
        cell.timeLabel.text = eventHelper.initTimeCell(indexPath: indexPath)
        cell.event = evenCell[indexPath.row]

        return cell
    }
}
