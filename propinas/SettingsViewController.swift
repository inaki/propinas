//
//  SettingsViewController.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/16/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate{
    func editFinished(controller: SettingsViewController, tips:[Double])
}

class SettingsViewController : UIViewController{
    var delegate:SettingsViewControllerDelegate? = nil
    
    var poorFieldText = String()
    var avgFieldText = String()
    var goodFieldText = String()
    
    @IBOutlet weak var poorTipField: UITextField!
    @IBOutlet weak var avgTipField: UITextField!
    @IBOutlet weak var goodTipField: UITextField!
    
    @IBAction func saveTip(sender: AnyObject) {
        if (delegate != nil) {
            var poorTipDouble = (NSString(string: poorTipField.text).doubleValue / 100)
            var avgTipDouble = (NSString(string: avgTipField.text).doubleValue / 100)
            var goodTipDouble = (NSString(string: goodTipField.text).doubleValue / 100)
            delegate!.editFinished(self, tips: [poorTipDouble, avgTipDouble, goodTipDouble])
            println(poorTipDouble)
        }
    }
    
    override func viewDidLoad() {
        poorTipField.text = poorFieldText
        avgTipField.text = avgFieldText
        goodTipField.text = goodFieldText
    }
}