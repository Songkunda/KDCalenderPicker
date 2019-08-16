import UIKit
class KDSelectTableCell: UITableViewCell {
    var model: KDSelectTableCellModel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // fixed: for iPad
        separatorInset = .init(top: 0, left: 0, bottom: 0, right: bounds.size.width)
        layoutMargins = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(cellModel: KDSelectTableCellModel) {
        model = cellModel
        textLabel?.font = .systemFont(ofSize: 12)
        textLabel?.text = cellModel.name
    }
}
