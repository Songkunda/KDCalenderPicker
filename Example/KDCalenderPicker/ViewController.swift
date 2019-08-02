//
//  ViewController.swift
//  KDCalenderPicker
//
//  Created by Kunda.Song on 07/31/2019.
//  Copyright (c) 2019 Kunda.Song. All rights reserved.
//

import UIKit
import KDCalenderPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @IBAction func chooseDate(_ sender: Any) {
        let picker = KDCalenderPickerVC()
        self.present(picker, animated: true) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

