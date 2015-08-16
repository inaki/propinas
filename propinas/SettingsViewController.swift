//
//  SettingsViewController.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/16/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController{
    
    
    @IBOutlet weak var poorTipPct: UILabel!
    @IBOutlet weak var averageTipPctLabel: UILabel!
    @IBOutlet weak var goodTipPctLabel: UILabel!
    
    var poorLabelText = String()
    var avgLabelText = String()
    var goodLabelText = String()
    
    override func viewDidLoad() {
        poorTipPct.text = poorLabelText
        averageTipPctLabel.text = avgLabelText
        goodTipPctLabel.text = goodLabelText
    }
}