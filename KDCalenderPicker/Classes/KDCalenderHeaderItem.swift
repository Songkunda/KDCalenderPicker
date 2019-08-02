//
//  KDCalenderHeaderItem.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/1.
//

import UIKit

class KDCalenderHeaderItem: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
