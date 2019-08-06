//
//  KDTimeRangeChooser.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/8/2.
//

import Foundation
import JTAppleCalendar
import UIKit

class KDTimeRangeChooser: UIView {
    var delegate: UIViewController?
    var isSetup = false
    var poper: UIView?
    let sCaLab = UILabel(frame: .zero)
    var beginDate:Date? = Date()
    var endDate:Date? = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        if isSetup == false {
            isSetup = true
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let todayStr = formatter.string(from: Date())
            // 88 - 13 - 88
            sCaLab.text = todayStr
            sCaLab.textAlignment = .center
            sCaLab.font = UIFont.systemFont(ofSize: 12.0)
            sCaLab.translatesAutoresizingMaskIntoConstraints = false
            sCaLab.adjustsFontSizeToFitWidth = true
            sCaLab.layer.cornerRadius = 2
            sCaLab.layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
            sCaLab.layer.borderWidth = 1
            sCaLab.layer.backgroundColor = UIColor(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
            sCaLab.alpha = 1
            addSubview(sCaLab)
            let kLab = UILabel(frame: .zero)
            kLab.text = "-"
            kLab.font = UIFont.systemFont(ofSize: 12.0)
            kLab.textAlignment = .center
            kLab.translatesAutoresizingMaskIntoConstraints = false
            addSubview(kLab)
            let eCaLab = UILabel(frame: .zero)
            eCaLab.text = todayStr
            eCaLab.font = UIFont.systemFont(ofSize: 12.0)
            eCaLab.textAlignment = .center
            eCaLab.translatesAutoresizingMaskIntoConstraints = false
            eCaLab.adjustsFontSizeToFitWidth = true
            eCaLab.layer.cornerRadius = 2
            eCaLab.layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
            eCaLab.layer.borderWidth = 1
            eCaLab.layer.backgroundColor = UIColor(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
            eCaLab.alpha = 1
            addSubview(eCaLab)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[cs(==88@1000)]-[kl(==14)]-[ec(==cs@1000)]|", options: [], metrics: nil, views: ["cs": sCaLab, "ec": eCaLab, "kl": kLab]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[cs(24)]|", options: [.alignAllCenterY], metrics: nil, views: ["cs": sCaLab]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[kl(24)]|", options: [.alignAllCenterY], metrics: nil, views: ["kl": kLab]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ec(24)]|", options: [.alignAllCenterY], metrics: nil, views: ["ec": eCaLab]))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:[sf(>=190@1000)]", options: [], metrics: nil, views: ["sf": self]))
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[sf(>=24@1000)]", options: [.alignAllCenterY], metrics: nil, views: ["sf": self]))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if poper == nil {
            poper = {
                let popView = UIView(frame: .zero)
                popView.translatesAutoresizingMaskIntoConstraints = false
                popView.backgroundColor = .white
                popView.layer.cornerRadius = 2
                popView.layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
                popView.layer.borderWidth = 1
                popView.alpha = 1
                self.superview?.addSubview(popView)
                self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[cs]-(-88)-[pp(==512)]", options: [], metrics: nil, views: ["pp": popView, "cs": sCaLab]))
                self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[cs]-[pp(==280)]", options: [], metrics: nil, views: ["pp": popView, "cs": sCaLab]))
                //
                let beginCalendar = JTAppleCalendarView(frame: .zero)
                beginCalendar.translatesAutoresizingMaskIntoConstraints = false
                beginCalendar.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
                beginCalendar.ibCalendarDelegate = self
                beginCalendar.ibCalendarDataSource = self
            
                popView.addSubview(beginCalendar)
                popView.addConstraints([
                    NSLayoutConstraint(item: beginCalendar, attribute: .leading, relatedBy: .equal, toItem: popView, attribute: .leading, multiplier: 1, constant: 0),
                     NSLayoutConstraint(item: beginCalendar, attribute: .top, relatedBy: .equal, toItem: popView, attribute: .top, multiplier: 1, constant: 0),
                      NSLayoutConstraint(item: beginCalendar, attribute: .width, relatedBy: .equal, toItem: popView, attribute: .width, multiplier: 0.5, constant: 0),
                    NSLayoutConstraint(item: beginCalendar, attribute: .bottom, relatedBy: .equal, toItem: popView, attribute: .bottom, multiplier: 1, constant: 0),
                    ])
                
                return popView
            }()
            
        } else {
            poper = {
                poper?.removeFromSuperview()
                return nil
            }()
        }
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

extension KDTimeRangeChooser: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
}

extension KDTimeRangeChooser: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.dateLabel.text = cellState.text
        configureCell(view: cell, cellState: cellState)
    }
}
extension KDTimeRangeChooser { //for JTAppleCalendarViewDelegate
    func configureCell(view: JTAppleCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.black
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
}

class DateCell: JTAppleCell {
    var dateLabel: UILabel = UILabel(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dl]|", options: [], metrics: nil, views: ["dl":dateLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dl]|", options: [], metrics: nil, views: ["dl":dateLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
