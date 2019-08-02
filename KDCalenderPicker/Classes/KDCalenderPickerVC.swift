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

public protocol KDCalenderPickerVCDelegate: NSObjectProtocol {
    /// 确认按钮点击
    ///
    /// - Parameters:
    ///   - type: 模式
    ///   - times: 多个时间
    ///     - simple: 一个变量
    ///     - range: 两个个变量 [0]起始时间 [1]结束时间
    ///     - mutiple: 多个变量
    /// - Returns: (是否通过验证,警告话语)
    func submit(type: KDCalenderPickerStyle, times: [Date]) -> (Bool, String?)
}

public class KDCalenderPickerVC: UIViewController {
    var firstDay: KDCalenderFirstDayStyle = .locale
    var minDate: Date?
    var MaxDate: Date?
    var type: KDCalenderPickerStyle = .simple
    var delegate: KDCalenderPickerVCDelegate?
    //
    var currentYear: NSInteger?
    var currentMonth: NSInteger?
    var currentDay: NSInteger?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        super.modalPresentationStyle = .custom
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    @objc func goBack() {
        dismiss(animated: true) {
        }
    }

    @objc func submit() {
        var pass = false
        // 验证
        let (back, _) = delegate?.submit(type: type, times: []) ?? (true, nil)
        pass = back
        if pass {
            goBack()
        }
    }

    func setupUI() {
        // 点击非热区返回上一页
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.4)
        let backView = UIView(frame: .zero)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = .clear
        let rec = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backView.addGestureRecognizer(rec)
        view.addSubview(backView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: backView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: backView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.5, constant: 0),
        ])

        // 全部热区
        let popView = UIView(frame: .zero)
        popView.tag = 10001
        popView.translatesAutoresizingMaskIntoConstraints = false
        popView.backgroundColor = .gray
        view.addSubview(popView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: popView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: popView, attribute: .top, relatedBy: .equal, toItem: backView, attribute: .bottom, multiplier: 1, constant: 0),
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
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.blue, for: .normal)
        cancelBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        headerView.addSubview(cancelBtn)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: cancelBtn, attribute: .leading, relatedBy: .equal, toItem: headerView, attribute: .leading, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: cancelBtn, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0),
        ])

        let submitBtn = UIButton(type: .custom)
        submitBtn.translatesAutoresizingMaskIntoConstraints = false
        submitBtn.setTitle("确定", for: .normal)
        submitBtn.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitBtn.setTitleColor(.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1), for: .normal)
        headerView.addSubview(submitBtn)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: submitBtn, attribute: .trailing, relatedBy: .equal, toItem: headerView, attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: submitBtn, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: submitBtn, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        let titleLab = UILabel(frame: .zero)
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.text = "选择日期"
        titleLab.textColor = .init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        headerView.addSubview(titleLab)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLab, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLab, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLab, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        // 日历区
        getCurrentDate()
        // 植入滑动页面
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.headerReferenceSize = .init(width: UIScreen.main.bounds.width, height: 100)
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionV.backgroundColor = .red
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        collectionV.delegate = self
        collectionV.dataSource = self;
        //*
//        collectionV.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        //*
        //
        collectionV.scrollsToTop = false
        //开启分页
        collectionV.isPagingEnabled = true
        //隐藏进度条
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(KDCalenderCell.self, forCellWithReuseIdentifier: "KDCalenderCell")
        collectionV.register(KDCalenderHeaderItem.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "KDCalenderHeaderItem")
        popView.addSubview(collectionV)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: collectionV, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionV, attribute: .leading, relatedBy: .equal, toItem: popView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionV, attribute: .trailing, relatedBy: .equal, toItem: popView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: collectionV, attribute: .bottom, relatedBy: .equal, toItem: popView, attribute: .bottom, multiplier: 1, constant: 0),
        ])
        view.layoutIfNeeded()
        //移动到底
        collectionV.scrollToItem(at: .init(item: 0, section: 23), at: .top, animated: false)
    }

    // MARK: -获取当前时间

    fileprivate func getCurrentDate() {
        let components = Calendar.current
        currentYear = components.component(.year, from: Date())
        currentMonth = components.component(.month, from: Date())
        currentDay = components.component(.day, from: Date())
        print("\(currentYear).\(currentMonth).\(currentDay)")
    }

    // MARK: -获取数据源

    fileprivate func getDatasouce() {
        let weekArray = ["日", "一", "二", "三", "四", "五", "六"]
    }

    // 根据选中日期，获取相应NSDate
    fileprivate func getSelectDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 8
        dateComponents.day = 12
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }

    // 获取目标月份的天数
    fileprivate func numberOfDaysInMonth() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: getSelectDate())?.count ?? 0
    }

    fileprivate func firstDayOfWeekInMonth() -> Int {
        // 获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
        return Calendar.current.ordinality(of: .day, in: .weekOfYear, for: getSelectDate())!
    }
}

extension KDCalenderPickerVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
}

extension KDCalenderPickerVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "KDCalenderHeaderItem", for: indexPath) as! KDCalenderHeaderItem
            return header
        }
        return UICollectionReusableView(frame: .zero)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KDCalenderCell", for: indexPath) as! KDCalenderCell
 
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 24
    }

}
