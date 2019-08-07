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
        let footerView = KDTRCPopViewFooter(frame: .zero)
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
}

