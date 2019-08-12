import UIKit

public protocol KDSelectViewDateSource: class {
    func selectView(_ selectView: KDSelectView) -> [KDSelectTableCellModel]
}

public protocol KDSelectViewDelegate: class {
    func selectView(_ selectView: KDSelectView, selectedModel: KDSelectTableCellModel)
}

public class KDSelectView: UIView {
    let myLab = UILabel(frame: .zero)
    public weak var dataSource: KDSelectViewDateSource?
    public weak var delegate: KDSelectViewDelegate?
    let tableView = KDSelectTableView(frame: .zero, style: .plain)
    var tableViewLayoutHeight: NSLayoutConstraint?
    var tableViewShow = false
    var sources: [KDSelectTableCellModel] = []

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

    func setupUI() {
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

        tableView.delegate = self
        tableView.dataSource = self
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        tableViewShowSwitcher()
    }

    func tableViewShowSwitcher() {
        if tableViewShow == false {
            tableViewShow = true
            window?.addSubview(tableView)
            tableViewLayoutHeight = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0, constant: 0)
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
                tableViewLayoutHeight!,
                NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            ])
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.tableViewLayoutHeight!.constant = 120
            }
            tableView.layoutIfNeeded()
            tableView.selectRow(at: tableView.indexPathForSelectedRow, animated: true, scrollPosition: .middle)

        } else {
            tableViewShow = false
            UIView.animate(withDuration: 0.3) { [unowned self] in
                self.tableViewLayoutHeight!.constant = 0
            }
            tableView.removeFromSuperview()
            tableView.removeConstraints(tableView.constraints)
        }
    }

    deinit {
        print(self, #function)
    }
}

extension KDSelectView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sources = dataSource?.selectView(self) ?? []
        return sources.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(KDSelectTableCell.self)") as! KDSelectTableCell
        cell.set(cellModel: sources[indexPath.row])
        if tableView.indexPathForSelectedRow == nil {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
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
        tableViewShowSwitcher()
    }
}
