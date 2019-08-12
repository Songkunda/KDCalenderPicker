//
//  ViewController.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 07/31/2019.
//  Copyright (c) 2019 Kunda.Song. All rights reserved.
//

import KDCalenderPicker
import UIKit

class ViewController: UIViewController {
    @IBOutlet var selectView: KDSelectView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectView?.delegate = self
        selectView?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

extension ViewController: KDSelectViewDelegate {
    func selectView(_ selectView: KDSelectView, selectedModel: KDSelectTableCellModel) {
        print("Selected Cell \(selectedModel)")
    }
}

extension ViewController: KDSelectViewDateSource {
    func selectView(_ selectView: KDSelectView) -> [KDSelectTableCellModel] {
        return [
            KDSelectTableCellModel(key: "default", name: "全部"),
            KDSelectTableCellModel(key: "key1", name: "全部1"),
            KDSelectTableCellModel(key: "key2", name: "全部2"),
            KDSelectTableCellModel(key: "key3", name: "全部3"),
        ]
    }
}
