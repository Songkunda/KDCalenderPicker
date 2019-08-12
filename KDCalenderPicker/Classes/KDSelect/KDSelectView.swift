import UIKit

protocol KDSelectViewDateSource: class {
    func selectView(_ selectView: KDSelectView) -> [KDSelectTableCellModel]
}

class KDSelectView: UIView {
    let myLab = UILabel(frame: .zero)
    var dataSource: KDSelectViewDateSource?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print(accessibilityIdentifier ?? "no accessibilityIdentifier")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // 添加label
        myLab.translatesAutoresizingMaskIntoConstraints = false
        // 设置lab
        myLab.textColor = .init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        myLab.font = .systemFont(ofSize: 12.0)
        addSubview(myLab)
        let myPullImgV = UIImageView(image: UIImage(named: "kd_select_pull.png"))
        myPullImgV.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myPullImgV)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[ml]-[im(==20)]-|", options: [], metrics: nil, views: ["ml": myLab, "im": myPullImgV]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ml]|", options: [], metrics: nil, views: ["ml": myLab, "im": myPullImgV]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[im]|", options: [], metrics: nil, views: ["ml": myLab, "im": myPullImgV]))
    }
    
    deinit {
        print(self, #function)
    }
}
