//
//  EventDetailViewController.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import UIKit

class EventDetailViewController: UIViewController{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!

    var event: Event = Event()
    var isEditStatus = false
    var time = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        print(event)
    }
    
    @IBAction func editChange(_ sender: UIBarButtonItem) {
        isEditStatus = !isEditStatus
        editButton.title = isEditStatus ? "Save" : "Edit"
//        tableView.reloadData()
    }
}

extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EvenDetailtCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EvenDetailtCell

        cell.nameTextField.isEnabled = isEditStatus
        cell.descriptionText.isEditable = isEditStatus
        cell.timeLabel.text = time

        return cell
    }
}
