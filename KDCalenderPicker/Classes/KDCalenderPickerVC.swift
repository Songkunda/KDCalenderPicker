//
//  KDCalenderPickerVC.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/7/31.
//

import UIKit
public enum KDCalenderPickerStyle {
    /// 单个
    case simple
    /// 一串
    case range
    /// 多个
    case mutiple
}

public enum KDCalenderFirstDayStyle {
    /// 周日
    case locale
    /// 周一
    case mon
}

public class KDCalenderPickerVC: UIViewController {
    var firstDay: KDCalenderFirstDayStyle = .locale
    var minDate: Date?
    var MaxDate: Date?
    var type: KDCalenderPickerStyle = .simple

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        let popView = UIView(frame: .zero)
        popView.tag = 10001
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.backgroundColor = .gray
        view.addSubview(popView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: popView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0),
        ])
        // 添加头部
        let headerView = UIView(frame: .zero)
        headerView.tag = 10002
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        popView.addSubview(headerView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal, toItem: popView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal, toItem: popView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: popView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 45),
            ])
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
