import UIKit
class KDSelectTableCell: UITableViewCell {
    var model: KDSelectTableCellModel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
