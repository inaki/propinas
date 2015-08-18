//
//  ViewController.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/13/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, SettingsViewControllerDelegate{
    
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipOutputLabel: UILabel!
    @IBOutlet weak var totalOutputLabel: UILabel!
    @IBOutlet weak var tipPctTabs: UISegmentedControl!
    
    var poor = Double()
    var average = Double()
    var good = Double()
    
    var tips = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        poor = 0.1
        average = 0.15
        good = 0.20
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
        let tipPercentages = [poor, average, good]
        let tipPercentage = tipPercentages[tipPctTabs.selectedSegmentIndex]
        
        let moneyFormatString = "$ %.2f"
        
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
    
    func doubleToTextNoDecimal(tip : Double) -> String {
        var tipString:String = String(format: "%.0f", (round(tip * 100)))
        return tipString
    }
    
    func editFinished(controller: SettingsViewController, tips:[Double]) {
        poor = tips[0]
        average = tips[1]
        good = tips[2]
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segue2settings" {
            var destinationSettings = segue.destinationViewController as! SettingsViewController
            
            destinationSettings.poorFieldText = (doubleToTextNoDecimal(poor))
            
            destinationSettings.avgFieldText = (doubleToTextNoDecimal(average))
            
            destinationSettings.goodFieldText = (doubleToTextNoDecimal(good))
            
            destinationSettings.delegate = self
        
        }
        
    }



}

