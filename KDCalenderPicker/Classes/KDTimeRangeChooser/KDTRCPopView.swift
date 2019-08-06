//
//  KDTRCself.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
import JTAppleCalendar
class KDTRCPopView: UIView {
    

    var selectedStartDate: Date = Date() {
        didSet {
//            let pp = testCalendar.dateComponents([.year, .month], from: selectedStartDate)
//            let year = pp.year!
//            let month = pp.month!
//
//            print("\(year)年\(month)月")
        }
    }

    var selectedEndDate: Date = Date() {
        didSet {
        }
    }

    let beginCalendarView = KDTRCCalendarView(frame: .zero)
    let endCalendarView = KDTRCCalendarView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 2
        layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
        layer.borderWidth = 1
        alpha = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createBeginView() {
        beginCalendarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(beginCalendarView)
        addConstraints([
            NSLayoutConstraint(item: beginCalendarView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendarView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: -1),
            NSLayoutConstraint(item: beginCalendarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -35),
        ])
    }

    func createEndView() {
        endCalendarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(endCalendarView)
        addConstraints([
            NSLayoutConstraint(item: endCalendarView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endCalendarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endCalendarView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: -1),
            NSLayoutConstraint(item: endCalendarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -35),
        ])
    }

    func createFooterView() {
        let footerView = UIView(frame: .zero)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(footerView)
        addConstraints([
            NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 0, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 34),
        ])
    }

    func setupUI() {
        createBeginView()
        createEndView()
        createFooterView()
    }
}



class KDTRCCalendarView: UIView {
    var testCalendar = Calendar(identifier: .chinese)
    var selectedDate:Date = Date()
    var beginDate: Date = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
    var endDate: Date = Date()
    
    
    func getDate() -> Date {
        return Date()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let header = KDTimeRangeChooserHeader(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        addConstraints([
            NSLayoutConstraint(item: header, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 40),
        ])

        let weekLabels = KDTRCWeekLabels(frame: .zero)
        weekLabels.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weekLabels)
        addConstraints([
            NSLayoutConstraint(item: weekLabels, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weekLabels, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: 7 * 25),
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
            NSLayoutConstraint(item: beginCalendar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 0, constant: 25 * 7),
            NSLayoutConstraint(item: beginCalendar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
        ])
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
        calendar.cellSize = 25
        calendar.scrollingMode = .stopAtEachCalendarFrame
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
    }
}

extension KDTRCCalendarView: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! KDTRCDateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
}

extension KDTRCCalendarView { // for JTAppleCalendarViewDelegate
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? KDTRCDateCell else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }

    func handleCellTextColor(cell: KDTRCDateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = KDTimeRangeChooserStyle.normalColor
        } else {
            cell.dateLabel.textColor = KDTimeRangeChooserStyle.disColor
        }
    }
}
extension KDTRCCalendarView: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: beginDate, endDate: endDate, numberOfRows: 6,
                                       calendar: testCalendar,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid,
                                       firstDayOfWeek: DaysOfWeek.sunday)
    }
}
