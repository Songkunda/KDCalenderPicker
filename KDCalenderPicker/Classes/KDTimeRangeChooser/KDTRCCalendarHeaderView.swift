//
//  KDTRCCalendarHeaderView.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/7.
//

import Foundation

class KDTRCCalendarHeaderView: UIView {
    var changeMonth: ((Int) -> Void)?

    let titleLab = UILabel(frame: .zero)
    let leftBtn = UIButton(type: .custom)
    let rightBtn = UIButton(type: .custom)

    var year: Int?
    var month: Int?
    override init(frame: CGRect) {
        super.init(frame: frame)

        leftBtn.translatesAutoresizingMaskIntoConstraints = false
        leftBtn.setTitle("<", for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        leftBtn.setTitleColor(KDTimeRangeChooserStyle.normalColor, for: .normal)
        leftBtn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        addSubview(leftBtn)
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.textColor = KDTimeRangeChooserStyle.normalColor
        titleLab.textAlignment = .center
        titleLab.font = .systemFont(ofSize: 12)
        titleLab.sizeToFit()
        addSubview(titleLab)

        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.setTitle(">", for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        rightBtn.setTitleColor(KDTimeRangeChooserStyle.normalColor, for: .normal)
        rightBtn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        addSubview(rightBtn)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lb(==45)]-15-[ti]-15-[rb(==45)]-15-|", options: [], metrics: nil, views: ["lb": leftBtn, "rb": rightBtn, "ti": titleLab]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": leftBtn]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": titleLab]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": rightBtn]))
        // add line
        let line = UIView(frame: .zero)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = KDTimeRangeChooserStyle.borderColor
        addSubview(line)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: [], metrics: nil, views: ["line": line]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==1)]|", options: [], metrics: nil, views: ["line": line]))
    }

    @objc fileprivate func btnClicked(_ btn: UIButton) {
        if changeMonth != nil {
            changeMonth!(btn == leftBtn ? -1 : 1)
        }
    }

    func setTitle(withYear year: Int, andMonth month: Int) {
        self.year = year
        self.month = month
        titleLab.text = "\(year)年\(month)月"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
