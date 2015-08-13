//
//  ViewController.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/13/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipOutputLabel: UILabel!
    @IBOutlet weak var totalOutputLabel: UILabel!
    @IBOutlet weak var tipPctTabs: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipOutputLabel.text = "$0.00"
        totalOutputLabel.text = "$0.00"
        self.billAmountField.becomeFirstResponder()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
    }
    
    func updateTip() {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipPctTabs.selectedSegmentIndex]
        
        let moneyFormatString = "$%.2f"
        
        let billAmount = (billAmountField.text as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipOutputLabel.text = String(format: moneyFormatString, tip)
        totalOutputLabel.text = String(format: moneyFormatString, total)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("default_tip")
        println("got default tip: \(defaultTip)")
        switch defaultTip {
        case 0...2:
            tipPctTabs.selectedSegmentIndex = defaultTip
        default:
            tipPctTabs.selectedSegmentIndex = 0
        }
        
        // Recalculate the tip
        updateTip()
    }


}

