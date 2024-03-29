//
//  KDTRCself.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
import JTAppleCalendar
class KDTRCPopView: UIView {
    var cancelBtnClicked: (() -> Void)?
    var submitBtnClicked: (() -> Void)?
    let beginCalendarView = KDTRCCalendarView(frame: .zero)
    let endCalendarView = KDTRCCalendarView(frame: .zero)
    var beginSelectedTime = Date()
    var endSelectedTime = Date()
    var beginTime: Date
    var endTime = Date()
    public var timeZone = TimeZone(identifier: "Asia/Shanghai")!
    public var myCalendar = Calendar.current

    override init(frame: CGRect) {
        myCalendar.timeZone = timeZone
        beginTime = myCalendar.date(byAdding: .month, value: -12, to: Date())!
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 2
        layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
        layer.borderWidth = 1
        alpha = 1
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            setupUI()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(calenderView: KDTRCCalendarView) {
        calenderView.translatesAutoresizingMaskIntoConstraints = false
        calenderView.delegate = self
        calenderView.myCalendar = myCalendar
        calenderView.timeZone = timeZone
        addSubview(calenderView)
    }

    func createBeginView() {
        beginCalendarView.selectedDate = beginSelectedTime
        setup(calenderView: beginCalendarView)
        addConstraints([
            NSLayoutConstraint(item: beginCalendarView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: beginCalendarView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: -1),
            NSLayoutConstraint(item: beginCalendarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -35),
        ])
    }

    func createEndView() {
        endCalendarView.beginDate = myCalendar.date(byAdding: .day, value: -1, to: beginSelectedTime)!
        endCalendarView.endDate = endTime
        setup(calenderView: endCalendarView)
        endCalendarView.reloadDate(willSeleteDate: endSelectedTime)
        addConstraints([
            NSLayoutConstraint(item: endCalendarView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endCalendarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: endCalendarView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: -1),
            NSLayoutConstraint(item: endCalendarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -35),
        ])
    }

    func createFooterView() {
        let footerView = KDTRCPopViewFooter(frame: .zero)
        footerView.cancelCallBack = { [unowned self] in
            if self.cancelBtnClicked != nil { self.cancelBtnClicked!() }
        }
        footerView.submitCallBack = { [unowned self] in
            if self.submitBtnClicked != nil { self.submitBtnClicked!() }
        }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(footerView)
        addConstraints([
            NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 34),
        ])
    }

    func createLine() {
        let line = UIView(frame: .zero)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = KDTimeRangeChooserStyle.borderColor
        addSubview(line)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]-(34)-|", options: [], metrics: nil, views: ["line": line]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[line(==1)]", options: [], metrics: nil, views: ["line": line]))
        addConstraint(NSLayoutConstraint(item: line, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }

    func setupUI() {
        createBeginView()
        createEndView()
        createLine()
        createFooterView()
    }

    deinit {
        print(self, #function)
    }
}

extension KDTRCPopView: KDTRCCalendarViewDelegate {
    func selectedDate(_ calendarView: KDTRCCalendarView, didSelectDate date: Date) {
        if calendarView == beginCalendarView {
            beginSelectedTime = date
            let willBeginDate = myCalendar.date(byAdding: .month, value: 0, to: date)!
            endCalendarView.beginDate = willBeginDate > beginTime ? willBeginDate : beginTime
            let willEndDate = myCalendar.date(byAdding: .month, value: 1, to: date)!
            endCalendarView.endDate = endTime > willEndDate ? willEndDate : endTime
            endCalendarView.reloadDate(willSeleteDate: date)
        } else if calendarView == endCalendarView {
            endSelectedTime = date
        }
    }
}
