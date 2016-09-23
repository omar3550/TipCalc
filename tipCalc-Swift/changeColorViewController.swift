//
//  changeColorViewController.swift
//  tipCalc-Swift
//
//  Created by Omar Naziry on 22/09/16.
//

import UIKit

class changeColorViewController: UIViewController {
    var color: UIColor!
    @IBOutlet weak var per1: UITextField!
    @IBOutlet weak var per2: UITextField!
    @IBOutlet weak var per3: UITextField!
    
    @IBOutlet weak var colorPickerView: HRColorPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.colorPickerView.color = UIColor.blueColor()
        self.colorPickerView.addTarget(self, action: #selector(self.colorDidChange(_:)), forControlEvents: .ValueChanged)
        color = UIColor.blueColor()
        
        // Do any additional setup after loading the view.
    }
    
    func colorDidChange(colorPickerView : HRColorPickerView) -> Void {
        color = colorPickerView.color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        per1.text = String (format: "%d", (NSUserDefaults.standardUserDefaults().valueForKey("per1")?.intValue)!)
        //[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"per1"]]
        per2.text = String (format: "%d", (NSUserDefaults.standardUserDefaults().valueForKey("per2")?.intValue)!)
        per3.text = String (format: "%d", (NSUserDefaults.standardUserDefaults().valueForKey("per3")?.intValue)!)
        
    }

    @IBAction func btnSave(sender: AnyObject) {
        
        if per1.text!.characters.count > 0 && per2.text!.characters.count > 0 && per3.text!.characters.count > 0{
            self.view.endEditing(true)
            
            let f = NSNumberFormatter()
            f.numberStyle = .NoStyle
            //        NSNumber *myNumber = [f numberFromString:@"42"];
            NSUserDefaults.standardUserDefaults().setObject(f.numberFromString(per1.text!), forKey: "per1")
            NSUserDefaults.standardUserDefaults().setObject(f.numberFromString(per2.text!), forKey: "per2")
            NSUserDefaults.standardUserDefaults().setObject(f.numberFromString(per3.text!), forKey: "per3")

            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        else{
            let alert = UIAlertView(title: "Warning", message: "Please fill up all values.", delegate: self, cancelButtonTitle: "Ok")
            alert.show()
        }
        
    }
    
    
    @IBAction func actionDone(sender: AnyObject) {
        
        let colorData = NSKeyedArchiver.archivedDataWithRootObject(color)
        NSUserDefaults.standardUserDefaults().setObject(colorData, forKey: "theme")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
