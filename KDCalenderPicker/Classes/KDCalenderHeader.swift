//
//  KDCalenderHeader.swift
//  FBSnapshotTestCase
//
//  Created by Kunda.Song on 2019/8/2.
//

import UIKit
protocol KDCalenderHeaderDelegate :NSObjectProtocol{
    func changeMonth(next:Bool)
}

class KDCalenderHeader: UIView {
   weak var delegate:KDCalenderHeaderDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
