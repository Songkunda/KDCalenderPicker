//
//  File.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/7.
//

import Foundation
import JTAppleCalendar

let KDTRCCalendarViewCellSize: CGFloat = 30

class KDTRCCalendarView: UIView {
    var selectedDate: Date = Date()
    var beginDate: Date = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
    var endDate: Date = Date()
    let header = KDTRCCalendarHeaderView(frame: .zero)

    func getDate() -> Date {
        return Date()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        addConstraints([
            NSLayoutConstraint(item: header, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 40),
        ])

        let weekLabels = KDTRCCalendarWeekLabels(frame: .zero)
        weekLabels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weekLabels)
        addConstraints([
            NSLayoutConstraint(item: weekLabels, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weekLabels, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: 7 * KDTRCCalendarViewCellSize),
            NSLayoutConstraint(item: weekLabels, attribute: .top, relatedBy: .equal, toItem: header, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weekLabels, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 25),
        ])

        let beginCalendar = JTAppleCalendarView(frame: .zero)
        setCalendar(beginCalendar)
        beginCalendar.selectDates(from: Date(), to: Date())
        addSubview(beginCalendar)
        addConstraints([
            NSLayoutConstraint(item: beginCalendar, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendar, attribute: .top, relatedBy: .equal, toItem: weekLabels, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: KDTRCCalendarViewCellSize * 7),
            NSLayoutConstraint(item: beginCalendar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        beginCalendar.visibleDates { [unowned self] (visibleDates: DateSegmentInfo) in
            self.headerTextUpdate(visibleDates)
        }
        beginCalendar.scrollToDate(Date(), animateScroll: false)
    }

    func headerTextUpdate(_ visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let dateComponents = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 28800)!, from: startDate)

        header.titleLab.text = "\(dateComponents.year!)年\(dateComponents.month!)月"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCalendar(_ calendar: JTAppleCalendarView) {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.register(KDTRCDateCell.self, forCellWithReuseIdentifier: "dateCell")
        calendar.scrollDirection = .horizontal
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.showsHorizontalScrollIndicator = false
        calendar.ibCalendarDelegate = self
        calendar.ibCalendarDataSource = self
        calendar.backgroundColor = KDTimeRangeChooserStyle.bgColor
        calendar.cellSize = KDTRCCalendarViewCellSize
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
    }
}

extension KDTRCCalendarView: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        (cell as? KDTRCDateCell)?.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate)
    }

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! KDTRCDateCell
        cell.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedDate = date
        (cell as? KDTRCDateCell)?.cellSelectionChanged(cellState, date: date)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        (cell as? KDTRCDateCell)?.cellSelectionChanged(cellState, date: date)
    }

    // 滑动停止
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        headerTextUpdate(visibleDates)
    }
}

extension KDTRCCalendarView: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        // CCT
        // let dateComponents = Calendar.current.dateComponents(in:  TimeZone(abbreviation: "GMT+0800") ?? TimeZone(secondsFromGMT: 28800)!, from: Date())
        //  print("\(dateComponents.year)年\(dateComponents.month)月\(dateComponents.day)日")

        return ConfigurationParameters(startDate: beginDate, endDate: endDate, numberOfRows: 6,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid,
                                       firstDayOfWeek: DaysOfWeek.sunday)
    }
}
