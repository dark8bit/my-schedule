//
//  EventViewCell.swift
//  MySchedule
//
//  Created by Владислав Клепиков on 26.10.2021.
//

import UIKit

class EventViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriprionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    let eventHelper = EventHelper.shared

    var event = Event()

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.text = event.name.count > 0 ? event.name : "События нет"
        descriprionLabel.text = event.description ?? "Пусто"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
