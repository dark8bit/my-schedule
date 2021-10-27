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

    var event = EventCell()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
