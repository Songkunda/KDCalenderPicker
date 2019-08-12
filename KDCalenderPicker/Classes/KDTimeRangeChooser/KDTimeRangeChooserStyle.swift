//
//  KDTimeRangeChooserStyle.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 2019/8/6.
//

import Foundation
class KDTimeRangeChooserStyle {
    static var style = (
        currtColor: UIColor(red: 66.0 / 255.0, green: 192.0 / 255.0, blue: 155.0 / 255.0, alpha: 1.0),
        currtTextColor: UIColor.white,
        bgColor: UIColor.white,
        disColor: UIColor(red: 195.0 / 255.0, green: 206.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0),
        normalColor: UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0),
        borderColor: UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0),
        labBGColor: UIColor(red: 248.0 / 255.0, green: 249.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    )
    class var currtColor: UIColor {
        return KDTimeRangeChooserStyle.style.currtColor
    }

    class var currtTextColor: UIColor {
        return KDTimeRangeChooserStyle.style.currtTextColor
    }

    class var bgColor: UIColor {
        return KDTimeRangeChooserStyle.style.bgColor
    }

    class var disColor: UIColor {
        return KDTimeRangeChooserStyle.style.disColor
    }

    class var normalColor: UIColor {
        return KDTimeRangeChooserStyle.style.normalColor
    }

    class var borderColor: UIColor {
        return KDTimeRangeChooserStyle.style.borderColor
    }

    class var labBGColor: UIColor {
        return KDTimeRangeChooserStyle.style.labBGColor
    }
    
    deinit {
        print(self, #function)
    }
}
