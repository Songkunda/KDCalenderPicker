import UIKit

public protocol KDSelectViewDataSource: class {
    func selectView(_ selectView: KDSelectView) -> [KDSelectTableCellModel]
}

public protocol KDSelectViewDelegate: class {
    func selectView(_ selectView: KDSelectView, selectedModel: KDSelectTableCellModel)
}

public class KDSelectView: UIView {
    let myLab = UILabel(frame: .zero)
    public weak var dataSource: KDSelectViewDataSource? {
        didSet {
            sources = dataSource?.selectView(self) ?? []
            myLab.text = sources.first?.name
        }
    }

    public weak var delegate: KDSelectViewDelegate?
    let tableView = KDSelectTableView(frame: .init(origin: .zero, size: .init(width: 1, height: 1)), style: .plain)
    var tableViewLayoutHeight: NSLayoutConstraint?
    var tableViewShow = false
    var sources: [KDSelectTableCellModel] = []
    ///返回被选择项
    var selectedModel: KDSelectTableCellModel? {
        if let indexPath = tableView.indexPathForSelectedRow {
            return sources[indexPath.row]
        }
        return nil
    }

    fileprivate func isDisabledChange() {
        if isDisabled {
            if tableViewShow == true {
                tableViewShowSwitcher()
            }
            alpha = 0.5
            isUserInteractionEnabled = false
        } else {
            alpha = 1
            isUserInteractionEnabled = true
        }
    }

    public var isDisabled = false {
        didSet {
            isDisabledChange()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func reloadData() {
        sources = dataSource?.selectView(self) ?? []
        myLab.text = sources.first?.name
        tableView.reloadData()
    }

    func setupUI() {
        //
        layer.cornerRadius = 2
        layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
        layer.borderWidth = 1
        backgroundColor = KDTimeRangeChooserStyle.labBGColor
        // 添加label
        myLab.translatesAutoresizingMaskIntoConstraints = false
        // 设置lab
        myLab.textColor = .init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        myLab.font = .systemFont(ofSize: 12.0)
        addSubview(myLab)

        let myPullImgV = UIImageView(image: UIImage(contentsOfFile: Bundle(for: classForCoder).path(forResource: "kd_select_pull", ofType: "png", inDirectory: "KDCalenderPicker.bundle") ?? "KDCalenderPicker.bundle/kd_select_pull.png"))
        myPullImgV.translatesAutoresizingMaskIntoConstraints = false
        myPullImgV.contentMode = .center
        addSubview(myPullImgV)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[ml]-[im(==20)]-|", options: [], metrics: nil, views: ["ml": myLab, "im": myPullImgV]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ml]|", options: [], metrics: nil, views: ["ml": myLab, "im": myPullImgV]))
        addConstraint(NSLayoutConstraint(item: myPullImgV, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //
        tableView.register(KDSelectTableCell.self, forCellReuseIdentifier: "\(KDSelectTableCell.self)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 1
        tableView.layer.borderColor = KDTimeRangeChooserStyle.borderColor.cgColor
        tableView.layer.borderWidth = 1

        tableView.delegate = self
        tableView.dataSource = self
        isDisabledChange()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isDisabled {
            return
        }
        tableViewShowSwitcher()
    }

    public override func removeFromSuperview() {
        tableView.removeFromSuperview()
        super.removeFromSuperview()
    }

    func tableViewShowSwitcher() {
        if tableViewShow == false {
            tableViewShow = true
            if tableViewLayoutHeight == nil {
                window?.addSubview(tableView)
                tableViewLayoutHeight = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 1)
                NSLayoutConstraint.activate([
                    NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
                    tableViewLayoutHeight!,
                    NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
                ])
            }
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.tableViewLayoutHeight!.constant = 120
            })

        } else {
            tableViewShow = false
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.tableViewLayoutHeight!.constant = 1
            }
        }
    }

    deinit {
        print(self, #function)
    }
}

extension KDSelectView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(KDSelectTableCell.self)") as! KDSelectTableCell
        cell.set(cellModel: sources[indexPath.row])
        if tableView.indexPathForSelectedRow == nil {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}

extension KDSelectView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectView(self, selectedModel: sources[indexPath.row])
        myLab.text = sources[indexPath.row].name
        tableViewShowSwitcher()
    }
}
