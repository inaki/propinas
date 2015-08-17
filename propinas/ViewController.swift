//
//  ViewController.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/13/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, SettingsViewControllerDelegate, SMSegmentViewDelegate{
    
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipOutputLabel: UILabel!
    @IBOutlet weak var totalOutputLabel: UILabel!
    @IBOutlet weak var tipPctTabs: UISegmentedControl!
    
    var segmentView: SMSegmentView!
    var margin: CGFloat = 10.0
    
    var poor = Double()
    var average = Double()
    var good = Double()
    
    var tips = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        poor = 0.1
        average = 0.15
        good = 0.20
        self.billAmountField.becomeFirstResponder()
        
        /*
        Init SMsegmentView
        Use a Dictionary here to set its properties.
        Each property has its own default value, so you only need to specify for those you are interested.
        */
        self.segmentView = SMSegmentView(frame: CGRect(x: self.margin, y: 250.0, width: self.view.frame.size.width - self.margin*2, height: 40.0), separatorColour: UIColor(white: 0.95, alpha: 0.3), separatorWidth: 0.5, segmentProperties: [keySegmentTitleFont: UIFont.systemFontOfSize(12.0), keySegmentOnSelectionColour: UIColor(red: 245.0/255.0, green: 174.0/255.0, blue: 63.0/255.0, alpha: 1.0), keySegmentOffSelectionColour: UIColor.whiteColor(), keyContentVerticalMargin: Float(10.0)])
        
        self.segmentView.delegate = self
        
        self.segmentView.layer.cornerRadius = 5.0
        self.segmentView.layer.borderColor = UIColor(white: 0.85, alpha: 1.0).CGColor
        self.segmentView.layer.borderWidth = 1.0
        
        // Add segments
        self.segmentView.addSegmentWithTitle("poor", onSelectionImage: UIImage(named: "poor_light"), offSelectionImage: UIImage(named: "poor"))
        self.segmentView.addSegmentWithTitle("average", onSelectionImage: UIImage(named: "average_light"), offSelectionImage: UIImage(named: "average"))
        self.segmentView.addSegmentWithTitle("good", onSelectionImage: UIImage(named: "good_light"), offSelectionImage: UIImage(named: "good"))
        
        // Set segment with index 0 as selected by default
        //segmentView.selectSegmentAtIndex(0)
        
        self.view.addSubview(self.segmentView)
        
    }
    
    // SMSegment Delegate
    func segmentView(segmentView: SMSegmentView, didSelectSegmentAtIndex index: Int) {
        let tipPercentages = [poor, average, good]
        let tipPercentage = tipPercentages[index]
        
        let moneyFormatString = "$%.2f"
        
        let billAmount = (billAmountField.text as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipOutputLabel.text = String(format: moneyFormatString, tip)
        totalOutputLabel.text = String(format: moneyFormatString, total)
        println("Select segment at index: \(index)")
        
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        /*
        MARK: Replace the following line to your own frame setting for segmentView.
        */
        if toInterfaceOrientation == UIInterfaceOrientation.LandscapeLeft || toInterfaceOrientation == UIInterfaceOrientation.LandscapeRight {
            self.segmentView.organiseMode = .SegmentOrganiseVertical
            self.segmentView.segmentVerticalMargin = 25.0
            self.segmentView.frame = CGRect(x: self.view.frame.size.width/2 - 40.0, y: 100.0, width: 80.0, height: 220.0)
        }
        else {
            self.segmentView.organiseMode = .SegmentOrganiseHorizontal
            self.segmentView.segmentVerticalMargin = 10.0
            self.segmentView.frame = CGRect(x: self.margin, y: 120.0, width: self.view.frame.size.width - self.margin*2, height: 40.0)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
    }
    
    func updateTip() {
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

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

