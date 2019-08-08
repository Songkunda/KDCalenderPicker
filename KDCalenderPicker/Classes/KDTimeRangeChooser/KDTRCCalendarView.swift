//
//  File.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/7.
//

import Foundation
import JTAppleCalendar

let KDTRCCalendarViewCellSize: CGFloat = 30
protocol KDTRCCalendarViewDelegate: NSObjectProtocol {
    func selectedDate(_ calendarView: KDTRCCalendarView, didSelectDate date: Date)
}

class KDTRCCalendarView: UIView {
    var selectedDate: Date = Date()
    var beginDate: Date = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
    var endDate: Date = Date()
    fileprivate let header = KDTRCCalendarHeaderView(frame: .zero)
    fileprivate let myCalendar = JTAppleCalendarView(frame: .zero)
    var delegate: KDTRCCalendarViewDelegate?

    fileprivate func setupUI() {
        header.translatesAutoresizingMaskIntoConstraints = false
        header.changeMonth = { todo in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM"
            var month = (self.header.month ?? 1) + todo
            var year = self.header.year ?? 2019
            if month < 1 {
                month = 12
                year -= 1
            } else if month > 12 {
                month = 1
                year += 1
            }

            if let startDate = formatter.date(from: "\(year) \(month)") {
                self.myCalendar.scrollToDate(startDate)
            }
        }
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

        setCalendar(myCalendar)
        myCalendar.selectDates(from: selectedDate, to: selectedDate)
        myCalendar.scrollToDate(selectedDate, animateScroll: false)
        addSubview(myCalendar)
        addConstraints([
            NSLayoutConstraint(item: myCalendar, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: myCalendar, attribute: .top, relatedBy: .equal, toItem: weekLabels, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: myCalendar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: KDTRCCalendarViewCellSize * 7),
            NSLayoutConstraint(item: myCalendar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        myCalendar.visibleDates { [unowned self] (visibleDates: DateSegmentInfo) in
            self.headerTextUpdate(visibleDates)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupUI()
    }

    func headerTextUpdate(_ visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let dateComponents = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 28800)!, from: startDate)
        header.setTitle(withYear: dateComponents.year!, andMonth: dateComponents.month!)
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

    func reloadDate(willSeleteDate: Date) {
        if beginDate > selectedDate || selectedDate > endDate {
            selectedDate = willSeleteDate
        }

        myCalendar.reloadData()
        myCalendar.visibleDates { [unowned self] (visibleDates: DateSegmentInfo) in
            self.headerTextUpdate(visibleDates)
            self.myCalendar.selectDates(from: self.selectedDate, to: self.selectedDate)
            self.myCalendar.scrollToDate(self.selectedDate, animateScroll: false)
        }
    }
}

extension KDTRCCalendarView: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        (cell as? KDTRCDateCell)?.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate, beginDate: beginDate, endDate: endDate)
    }

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! KDTRCDateCell
        cell.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate, beginDate: beginDate, endDate: endDate)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedDate = date
        (cell as? KDTRCDateCell)?.cellSelectionChanged(cellState, date: date, beginDate: beginDate, endDate: endDate)
        calendar.scrollToDate(date)
        delegate?.selectedDate(self, didSelectDate: date)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        (cell as? KDTRCDateCell)?.cellSelectionChanged(cellState, date: date, beginDate: beginDate, endDate: endDate)
    }

    /// 滑动停止后调用
    ///
    /// 用于修改头部月份
    ///
    /// - Parameters:
    ///   - calendar: 日历
    ///   - visibleDates: 包含日历中可见日期的信息
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        headerTextUpdate(visibleDates)
    }
}

extension KDTRCCalendarView: JTAppleCalendarViewDataSource {
    /// 日历配置数据获取
    ///
    /// - Parameter calendar: 日历
    /// - Returns: 配置数据
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
