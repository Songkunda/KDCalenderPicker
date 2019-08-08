//
//  KDTRCWeekLabels.swift
//  JTAppleCalendar
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
class KDTRCCalendarWeekLabels: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        var visualFormat = "H:|"
        var visualViews: [String: Any] = [:]
        for i in 0 ... 6 {
            let lab = UILabel(frame: .zero)
            lab.translatesAutoresizingMaskIntoConstraints = false
            lab.text = week(i)
            lab.textAlignment = .center
            lab.font = .systemFont(ofSize: 12.0)
            lab.textColor = KDTimeRangeChooserStyle.disColor
            visualFormat += "[lb\(i)(==cs)]"
            visualViews["lb\(i)"] = lab
            addSubview(lab)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lb]|", options: [], metrics: nil, views: ["lb": lab]))
        }
        visualFormat += "|"
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: [], metrics: ["cs": KDTRCCalendarViewCellSize], views: visualViews))
    }

    func week(_ weekNumber: Int) -> String? {
        switch weekNumber {
        case 0:
            return "日"
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        default:
            return nil
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
