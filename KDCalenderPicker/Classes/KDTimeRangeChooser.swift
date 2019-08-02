//
import Foundation
import Koyomi
//  KDTimeRangeChooser.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/8/2.
//
import UIKit

class KDTimeRangeChooser: UIView {
    var delegate: UIViewController?
    var isSetup = false
    var poper: UIView?
    let sCaLab = UILabel(frame: .zero)

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
                    let koyomi = Koyomi(frame: .zero, sectionSpace: 0, cellSpace: 0, inset: .zero, weekCellHeight: 20)
                    koyomi.translatesAutoresizingMaskIntoConstraints = false
                    koyomi.weeks = ("日", "一", "二", "三", "四", "五", "六")
                    koyomi.currentDateFormat = "yyyy年M月"
                    //选择今日
                    let today = Date()
                    koyomi.select(date: today)
                    //
                    koyomi.selectedStyleColor = UIColor(red: 66.0 / 255.0, green: 192.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0)
                    let textBlack = UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
                    let textGray = UIColor(red: 195.0 / 255.0, green: 206.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0)
                    let customColorScheme:KoyomiStyle.CustomColorScheme = (dayBackgrond: UIColor.white,
                                                                           weekBackgrond: UIColor.white,
                                                                           week: textGray,
                                                                           weekday: textBlack,
                                                                           holiday: (saturday: textBlack, sunday: textBlack),
                                                                           otherMonth:textGray,
                                                                           separator: UIColor.green)
                    
                    koyomi.style = KoyomiStyle.custom(customColor: customColorScheme)
                    //
                    popView.addSubview(koyomi)
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[sk(==240@1000)]", options: [], metrics: nil, views: ["sk":koyomi]))
                    return koyomi
                }()
                //
                endKoyomi = {
                    let koyomi = Koyomi(frame: .zero, sectionSpace: 1.5, cellSpace: 0.5, inset: .zero, weekCellHeight: 25)
                    koyomi.translatesAutoresizingMaskIntoConstraints = false
                    popView.addSubview(koyomi)
                    popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ek(==240@1000)]", options: [], metrics: nil, views: ["ek":koyomi]))
                    return koyomi
                }()
                //
                popView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[sk][ek(==sk@1000)]|", options: [], metrics: nil, views: ["sk":startKoyomi!,"ek":endKoyomi!]))
                
                
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
