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
    let eCaLab = UILabel(frame: .zero)

    var selectedStartDate: Date = Date()

    var selectedEndDate: Date = Date()

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
            sCaLab.layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
            sCaLab.layer.borderWidth = 1
            sCaLab.backgroundColor = UIColor(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
            sCaLab.alpha = 1
            addSubview(sCaLab)
            let kLab = UILabel(frame: .zero)
            kLab.text = "-"
            kLab.font = UIFont.systemFont(ofSize: 12.0)
            kLab.textAlignment = .center
            kLab.translatesAutoresizingMaskIntoConstraints = false
            addSubview(kLab)

            eCaLab.text = todayStr
            eCaLab.font = UIFont.systemFont(ofSize: 12.0)
            eCaLab.textAlignment = .center
            eCaLab.translatesAutoresizingMaskIntoConstraints = false
            eCaLab.adjustsFontSizeToFitWidth = true
            eCaLab.layer.cornerRadius = 2
            eCaLab.layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
            eCaLab.layer.borderWidth = 1
            eCaLab.layer.backgroundColor = KDTimeRangeChooserStyle.labBGColor.cgColor
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
                let popView = KDTRCPopView(frame: .zero)
                popView.selectedStartDate = selectedStartDate
                popView.selectedEndDate = selectedEndDate
                popView.translatesAutoresizingMaskIntoConstraints = false
                self.superview?.addSubview(popView)
                self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[cs]-(-88)-[pp(==512)]", options: [], metrics: nil, views: ["pp": popView, "cs": sCaLab]))
                self.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[cs]-[pp(==280)]", options: [], metrics: nil, views: ["pp": popView, "cs": sCaLab]))
                popView.setupUI()
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
