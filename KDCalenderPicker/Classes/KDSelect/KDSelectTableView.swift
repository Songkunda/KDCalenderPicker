import UIKit
public class KDSelectTableView: UITableView {
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        separatorStyle = .none
        separatorColor = backgroundColor ?? .white
        // fixed: for iPad
        layoutMargins = .zero
        separatorInset = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print(self, #function)
    }
}
