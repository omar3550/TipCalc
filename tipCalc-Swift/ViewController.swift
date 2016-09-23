//
//  ViewController.swift
//  tipCalc-Swift
//
//  Created by Omar Naziry on 22/09/16.
//

import UIKit

let kOFFSET_FOR_KEYBOARD = 80.0
let IDIOM = UI_USER_INTERFACE_IDIOM()
let IPAD = (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
let IS_IPAD : Bool = (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
let IS_IPHONE : Bool = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
let IS_RETINA = (UIScreen.mainScreen().scale >= 2.0)
let SCREEN_WIDTH = (UIScreen.mainScreen().bounds.size.width)
let SCREEN_HEIGHT = (UIScreen.mainScreen().bounds.size.height)
let SCREEN_MAX_LENGTH = (max(SCREEN_WIDTH, SCREEN_HEIGHT))
let SCREEN_MIN_LENGTH = (min(SCREEN_WIDTH, SCREEN_HEIGHT))
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

class ViewController: UIViewController {

    
    var percentage: Float = 0.0
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var people: UITextField!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var lblTipAmount: UILabel!
    @IBOutlet weak var lblTotalToPay: UILabel!
    @IBOutlet weak var lblTotalPerPerson: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    
    @IBOutlet weak var top1: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var vertical1: NSLayoutConstraint!
    @IBOutlet weak var vertical2: NSLayoutConstraint!
    @IBOutlet weak var heightLbls: NSLayoutConstraint!
    @IBOutlet weak var vertical3: NSLayoutConstraint!
    @IBOutlet weak var vetical4: NSLayoutConstraint!
    @IBOutlet weak var vetical5: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if IS_IPHONE_4_OR_LESS {
            self.top1.constant = 0
            self.viewHeight.constant = 55
            self.vertical1.constant = 0
            self.vertical2.constant = 5
            self.vertical3.constant = 5
            self.heightLbls.constant = 15
            self.vetical4.constant = 3
            self.vetical5.constant = 3
        }
        
        let colorData = NSUserDefaults.standardUserDefaults().valueForKey("theme") as! NSData
        let color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as! UIColor;

        self.view.backgroundColor = color
        
        percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per1")?.floatValue)!
        print(NSUserDefaults.standardUserDefaults().valueForKey("amount"))
        if NSUserDefaults.standardUserDefaults().valueForKey("amount") != nil {
            
            self.amount.text = String (format: "%d", (NSUserDefaults.standardUserDefaults().valueForKey("amount")?.intValue)!)
            self.lblTipAmount.text = self.calculateTip()
            self.lblTotalToPay.text = self.calculateTotalPay()
            self.lblTotalPerPerson.text = self.calculateTotalPayPerPerson()

        }
        self.view1.clipsToBounds = true
        self.view1.layer.borderColor = UIColor.whiteColor().CGColor
        self.view1.layer.borderWidth = 1.0
        self.view2.clipsToBounds = true
        self.view2.layer.borderColor = UIColor.whiteColor().CGColor
        self.view2.layer.borderWidth = 1.0

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        amount.becomeFirstResponder()
        
        segment.setTitle(String(format: "%d%%", (NSUserDefaults.standardUserDefaults().valueForKey("per1")?.intValue)!), forSegmentAtIndex: 0)
        segment.setTitle(String(format: "%d%%", (NSUserDefaults.standardUserDefaults().valueForKey("per2")?.intValue)!), forSegmentAtIndex: 1)
        segment.setTitle(String(format: "%d%%", (NSUserDefaults.standardUserDefaults().valueForKey("per3")?.intValue)!), forSegmentAtIndex: 2)
        
        if segment.selectedSegmentIndex == 0 {
            
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per1")?.floatValue)!
        }
        else if segment.selectedSegmentIndex == 1 {
            
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per2")?.floatValue)!
        }
        else{
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per3")?.floatValue)!

        }
        
        let colorData = NSUserDefaults.standardUserDefaults().valueForKey("theme") as! NSData
        let color = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as! UIColor;
        
        self.view.backgroundColor = color
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(sender: AnyObject) {
        if amount.text!.characters.count > 0 && people.text!.characters.count > 0 {
            self.lblTipAmount.text = self.calculateTip()
            self.lblTotalToPay.text = self.calculateTotalPay()
            self.lblTotalPerPerson.text = self.calculateTotalPayPerPerson()
            let f = NSNumberFormatter()
            f.numberStyle = .NoStyle
            let number = f.numberFromString(amount.text!)
            NSUserDefaults.standardUserDefaults().setObject(number, forKey: "amount")
            NSUserDefaults.standardUserDefaults().synchronize()
        print(NSUserDefaults.standardUserDefaults().valueForKey("amount"))
            
        
        }
        else {
            self.lblTipAmount.text = ""
            self.lblTotalToPay.text = ""
            self.lblTotalPerPerson.text = ""
        }
    }
    
    @IBAction func segmentChanged(sender: AnyObject) {
        
        if segment.selectedSegmentIndex == 0 {
            //        [myNSNumber floatValue]
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per1")?.floatValue)!
            if amount.text!.characters.count > 0 && people.text!.characters.count > 0 {
                self.lblTipAmount.text = self.calculateTip()
                self.lblTotalToPay.text = self.calculateTotalPay()
                self.lblTotalPerPerson.text = self.calculateTotalPayPerPerson()
            }
        }
        else if segment.selectedSegmentIndex == 1 {
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per2")?.floatValue)!
            if amount.text!.characters.count > 0 && people.text!.characters.count > 0 {
                self.lblTipAmount.text = self.calculateTip()
                self.lblTotalToPay.text = self.calculateTotalPay()
                self.lblTotalPerPerson.text = self.calculateTotalPayPerPerson()
            }
        }
        else{
            percentage = (NSUserDefaults.standardUserDefaults().valueForKey("per3")?.floatValue)!
            if amount.text!.characters.count > 0 && people.text!.characters.count > 0 {
                self.lblTipAmount.text = self.calculateTip()
                self.lblTotalToPay.text = self.calculateTotalPay()
                self.lblTotalPerPerson.text = self.calculateTotalPayPerPerson()
            }
        }
        
        
    }
    
    
    func calculateTip() -> String {
        let tip: Float = (CFloat(amount.text!)! * Float(percentage)) / 100
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = NSLocale.currentLocale()
        
        return String(format: "Tip Amount : %@",numberFormatter.stringFromNumber(NSNumber(float: tip))!)
        
    }
    
    
    func calculateTotalPay() -> String {
        let tip: Float = (CFloat(amount.text!)! * Float(percentage)) / 100
        let total: Float = CFloat(amount.text!)! + tip
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = NSLocale.currentLocale()
        
        return String(format: "Total to Pay : %@",numberFormatter.stringFromNumber(NSNumber(float: total))!)
    }
    
    
    
    func calculateTotalPayPerPerson() -> String {
        let tip: Float = (CFloat(amount.text!)! * Float(percentage)) / 100
        let total: Float = CFloat(amount.text!)! + tip
        let totalPerPerson: Float = total/CFloat(people.text!)!
//        float totalPerPerson = total / [_people.text floatValue];
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = NSLocale.currentLocale()
        
        return String(format: "Total per Person : %@",numberFormatter.stringFromNumber(NSNumber(float: totalPerPerson))!)
        
    }
    

}

