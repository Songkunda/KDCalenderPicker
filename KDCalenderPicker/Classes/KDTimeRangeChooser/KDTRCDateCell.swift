//
//  File.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
import JTAppleCalendar
let KDTRCDateCellSeletionDuration = 0.3

class KDTRCDateCell: JTAppleCell {
    var dayLabel: UILabel = UILabel(frame: .zero)
    var selectedView: UIView = UIView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        //

        selectedView.backgroundColor = KDTimeRangeChooserStyle.currtColor
        selectedView.center = contentView.center
        contentView.addSubview(selectedView)

        //
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.textAlignment = .center
        dayLabel.font = .systemFont(ofSize: 12.0)
        contentView.addSubview(dayLabel)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dl]|", options: [], metrics: nil, views: ["dl": dayLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dl]|", options: [], metrics: nil, views: ["dl": dayLabel]))
    }

    func handleCellSelection(cellState: CellState, date: Date, selectedDate: Date, beginDate: Date, endDate: Date) {
        // InDate, OutDate
        dayLabel.text = cellState.text
        dayLabel.textColor = (beginDate <= date && date <= endDate) ? KDTimeRangeChooserStyle.normalColor : KDTimeRangeChooserStyle.disColor
        isUserInteractionEnabled = (beginDate <= date && date <= endDate)
        configueViewIntoBubbleView(cellState, date: date, beginDate: beginDate, endDate: endDate)
    }

    func cellSelectionChanged(_ cellState: CellState, date: Date, beginDate: Date, endDate: Date) {
        configueViewIntoBubbleView(cellState, date: date, animateDeselection: true, beginDate: beginDate, endDate: endDate)
    }

    fileprivate func configueViewIntoBubbleView(_ cellState: CellState, date: Date, animateDeselection: Bool = false, beginDate: Date, endDate: Date) {
        if cellState.isSelected && isUserInteractionEnabled {
            UIView.animate(withDuration: KDTRCDateCellSeletionDuration, animations: {
                self.selectedView.frame.size = .init(width: 20, height: 20)
                self.selectedView.center = self.contentView.center
                self.selectedView.layer.cornerRadius = 10
                self.dayLabel.textColor = KDTimeRangeChooserStyle.currtTextColor
            })
        } else {
            if animateDeselection {
                UIView.animate(withDuration: KDTRCDateCellSeletionDuration, animations: {
                    self.selectedView.frame.size = .init(width: 0, height: 0)
                    self.selectedView.center = self.contentView.center
                    self.dayLabel.textColor = (beginDate <= date && date <= endDate && cellState.dateBelongsTo == .thisMonth) ? KDTimeRangeChooserStyle.normalColor : KDTimeRangeChooserStyle.disColor
                })
            } else {
                selectedView.frame.size = .init(width: 0, height: 0)
                selectedView.center = contentView.center
                dayLabel.textColor = (beginDate <= date && date <= endDate && cellState.dateBelongsTo == .thisMonth) ? KDTimeRangeChooserStyle.normalColor : KDTimeRangeChooserStyle.disColor
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
