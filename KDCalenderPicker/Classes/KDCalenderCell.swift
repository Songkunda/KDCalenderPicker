//
//  KDCalenderCell.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/8/1.
//

class KDCalenderCell: UICollectionViewCell {
    lazy var titleLab = UILabel(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .blue
        contentView.addSubview(titleLab)
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        titleLab.text = "1"
        titleLab.textAlignment = .center
        titleLab.backgroundColor = .yellow
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tb]-0-|", options: [], metrics: nil, views: ["tb": titleLab]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tb]-0-|", options: [], metrics: nil, views: ["tb": titleLab]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
