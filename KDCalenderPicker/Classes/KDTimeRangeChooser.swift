//
//  KDTimeRangeChooser.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/8/2.
//

import Foundation
import Koyomi
import UIKit

class KDTimeRangeChooser: UIView {
    var delegate: UIViewController?
    var isSetup = false
    var poper: UIView?
    let sCaLab = UILabel(frame: .zero)
    var beginDate:Date? = Date()
    var endDate:Date? = Date()
    
    var startKoyomi: Koyomi?
    var endKoyomi: Koyomi?
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
                startKoyomi = {
                    let (header, koyomi) = createKoyomi()
                    popView.addSubview(header)
                    popView.addSubview(koyomi)
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hd(==40@1000)][sk(==200@1000)]", options: [], metrics: nil, views: ["hd": header, "sk": koyomi]))
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[hd(==sk)]", options: [], metrics: nil, views: ["hd": header, "sk": koyomi]))
                    return koyomi
                }()
                //
                endKoyomi = {
                    let (header, koyomi) = createKoyomi()
                    popView.addSubview(header)
                    popView.addSubview(koyomi)
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[hd(==40@1000)][ek(==200@1000)]", options: [], metrics: nil, views: ["hd": header, "ek": koyomi]))
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[hd(==ek)]|", options: [], metrics: nil, views: ["hd": header, "ek": koyomi]))
                    return koyomi
                }()
                //
                popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sk][ek(==sk@1000)]|", options: [], metrics: nil, views: ["sk": startKoyomi!, "ek": endKoyomi!]))
                
                let footer = UIView(frame: .zero)
                footer.translatesAutoresizingMaskIntoConstraints = false
                let cancelBtn = UIButton(type: .custom)
                cancelBtn.translatesAutoresizingMaskIntoConstraints = false
                cancelBtn.layer.cornerRadius = 2
                cancelBtn.layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
                cancelBtn.layer.borderWidth = 1
                cancelBtn.setTitle("取消", for: .normal)
                cancelBtn.setTitleColor(UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1), for: .normal)
                cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
                footer.addSubview(cancelBtn)
                let submitBtn = UIButton(type: .custom)
                submitBtn.translatesAutoresizingMaskIntoConstraints = false
                submitBtn.setTitle("确定", for: .normal)
                submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
                submitBtn.layer.cornerRadius = 2
                submitBtn.backgroundColor = UIColor(red: 66.0 / 255.0, green: 192.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
                footer.addSubview(submitBtn)
                popView.addSubview(footer)
                popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[ft]|", options: [], metrics: nil, views: ["ft": footer]))
                popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[sk][ft]|", options: [], metrics: nil, views: ["ft": footer, "sk": startKoyomi!]))
                footer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[cb(==56)]-20-[sb(==cb@1000)]-20-|", options: [], metrics: nil, views: ["cb": cancelBtn, "sb": submitBtn]))
                footer.addConstraints([
                    NSLayoutConstraint(item: submitBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 25.0),
                    NSLayoutConstraint(item: cancelBtn, attribute: .centerY, relatedBy: .equal, toItem: footer, attribute: .centerY, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: cancelBtn, attribute: .height, relatedBy: .equal, toItem: submitBtn, attribute: .height, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: submitBtn, attribute: .centerY, relatedBy: .equal, toItem: footer, attribute: .centerY, multiplier: 1, constant: 0)])
                
                return popView
            }()
            
        } else {
            poper = {
                poper?.removeFromSuperview()
                return nil
            }()
        }
    }
    
    func createKoyomi() -> (KoyomiHeader, Koyomi) {
        let koyomiHeader = KoyomiHeader()
        koyomiHeader.translatesAutoresizingMaskIntoConstraints = false
        
        let koyomi = Koyomi(frame: .zero, sectionSpace: 0, cellSpace: 0, inset: .init(top: 8, left: 8, bottom: 8, right: 8), weekCellHeight: 30)
        koyomi.setDayFont(fontName: "Symbol", size: 12.0)
        koyomi.setWeekFont(fontName: "Symbol", size: 12.0)
        koyomi.translatesAutoresizingMaskIntoConstraints = false
        // 文字
        koyomi.weeks = ("日", "一", "二", "三", "四", "五", "六")
        koyomi.currentDateFormat = "yyyy年M月"
        // 选择今日
        let today = Date()
        koyomi.select(date: today)
        // 颜色
        koyomi.selectedStyleColor = UIColor(red: 66.0 / 255.0, green: 192.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
        let textBlack = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
        let textGray = UIColor(red: 195.0 / 255.0, green: 206.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0)
        let customColorScheme: KoyomiStyle.CustomColorScheme = (dayBackgrond: UIColor.white,
                                                                weekBackgrond: UIColor.white,
                                                                week: textGray,
                                                                weekday: textBlack,
                                                                holiday: (saturday: textBlack, sunday: textBlack),
                                                                otherMonth: textGray,
                                                                separator: .white)
        
        koyomi.style = KoyomiStyle.custom(customColor: customColorScheme)
        //
        koyomi.layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
        koyomi.layer.borderWidth = 1
        koyomi.alpha = 1
        //
        return (koyomiHeader, koyomi)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
}

class KoyomiHeader: UIView {
    let lockValue = 9000
    var isSetup = false
    weak var koymi: Koyomi?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        objc_sync_enter(lockValue)
        if isSetup == false {
            isSetup = true
            //
            layer.borderColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0).cgColor
            layer.borderWidth = 1
            alpha = 1
            //
            let leftBtn = UIButton(type: .custom)
            leftBtn.translatesAutoresizingMaskIntoConstraints = false
            leftBtn.setTitle("<", for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
            leftBtn.setTitleColor(UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0), for: .normal)
            addSubview(leftBtn)
            let titleLab = UILabel(frame: .zero)
            titleLab.translatesAutoresizingMaskIntoConstraints = false
            titleLab.text = "2019年7月"
            titleLab.textAlignment = .center
            titleLab.font = .systemFont(ofSize: 12)
            titleLab.sizeToFit()
            addSubview(titleLab)
            let rightBtn = UIButton(type: .custom)
            rightBtn.translatesAutoresizingMaskIntoConstraints = false
            rightBtn.setTitle(">", for: .normal)
            rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
            rightBtn.setTitleColor(UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0), for: .normal)
            addSubview(rightBtn)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lb(==45)]-15-[ti]-15-[rb(==45)]-15-|", options: [], metrics: nil, views: ["lb": leftBtn, "rb": rightBtn, "ti": titleLab]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": leftBtn]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": titleLab]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subV]|", options: [], metrics: nil, views: ["subV": rightBtn]))
        }
        objc_sync_exit(lockValue)
    }
}
