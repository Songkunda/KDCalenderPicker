//
//  File.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
import JTAppleCalendar

class KDTRCDateCell: JTAppleCell {
    var dateLabel: UILabel = UILabel(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 12.0)
        contentView.addSubview(dateLabel)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dl]|", options: [], metrics: nil, views: ["dl": dateLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dl]|", options: [], metrics: nil, views: ["dl": dateLabel]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
