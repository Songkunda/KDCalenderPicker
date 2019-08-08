//
//  KDTRCPopViewFooter.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/7.
//

import Foundation

class KDTRCPopViewFooter: UIView {
    var cancelCallBack: (() -> Void)?
    var submitCallBack: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add line
        let line = UIView(frame: .zero)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = KDTimeRangeChooserStyle.borderColor
        addSubview(line)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: [], metrics: nil, views: ["line": line]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==1)]", options: [], metrics: nil, views: ["line": line]))

        // add btns
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.layer.cornerRadius = 2
        cancelBtn.layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(KDTimeRangeChooserStyle.disColor, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        addSubview(cancelBtn)
        let submitBtn = UIButton(type: .custom)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.setTitle("确定", for: .normal)
        submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        submitBtn.layer.cornerRadius = 2
        submitBtn.backgroundColor = KDTimeRangeChooserStyle.currtColor
        submitBtn.addTarget(self, action: #selector(submitBtnClicked), for: .touchUpInside)
        addSubview(submitBtn)

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[cb(==56)]-20-[sb(==cb@1000)]-25-|", options: [], metrics: nil, views: ["cb": cancelBtn, "sb": submitBtn]))
        addConstraints([
            NSLayoutConstraint(item: submitBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 25.0),
            NSLayoutConstraint(item: cancelBtn, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cancelBtn, attribute: .height, relatedBy: .equal, toItem: submitBtn, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: submitBtn, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
    }

    @objc fileprivate func cancelBtnClicked() {
        if cancelCallBack != nil { cancelCallBack!() }
    }

    @objc fileprivate func submitBtnClicked() {
        if submitCallBack != nil { submitCallBack!() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
