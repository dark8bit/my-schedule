//
//  ViewController+TableView.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 27.10.2021.
//

import UIKit

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
