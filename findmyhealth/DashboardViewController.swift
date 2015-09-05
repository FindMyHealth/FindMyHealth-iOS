//
//  ViewController.swift
//  findmyhealth
//
//  Created by Haitham Maaieh on 9/5/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    let screenSize = UIScreen.mainScreen().bounds.size
    var settings = UIControl()
    var contacts = UIControl()
    var find = UIControl()
    var emergency = UIControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpInterface() {
        view.backgroundColor = UIColor.grayColor()
        
        settings.removeFromSuperview()
        contacts.removeFromSuperview()
        find.removeFromSuperview()
        emergency.removeFromSuperview()
        
        view.addSubview(settings)
        view.addSubview(contacts)
        view.addSubview(find)
        view.addSubview(emergency)
        
        formatControl(settings)
        formatControl(contacts)
        formatControl(find)
        formatControl(emergency)
        
        settings.center = CGPoint(x: screenSize.width/4, y: screenSize.height/2)
        contacts.center = CGPoint(x: screenSize.width*3/4, y: screenSize.height/2)
        find.center = CGPoint(x: screenSize.width/4, y: screenSize.height*3/4)
        emergency.center = CGPoint(x: screenSize.width*3/4, y: screenSize.height*3/4)
        
        let settingsLabel = UILabel()
        let contactsLabel = UILabel()
        let findLabel = UILabel()
        let emergencyLabel = UILabel()
        
        settings.addSubview(settingsLabel)
        contacts.addSubview(contactsLabel)
        find.addSubview(findLabel)
        emergency.addSubview(emergencyLabel)
        
        settings.backgroundColor = UIColor.blackColor()
        contacts.backgroundColor = UIColor.blueColor()
        find.backgroundColor = UIColor.greenColor()
        emergency.backgroundColor = UIColor.redColor()
        
        settingsLabel.text = "Edit Settings"
        contactsLabel.text = "Primary Contacts"
        findLabel.text = "Find My Health"
        emergencyLabel.text = "Emergency 911"
        
        applyLabelFormat(settingsLabel)
        applyLabelFormat(contactsLabel)
        applyLabelFormat(findLabel)
        applyLabelFormat(emergencyLabel)
        
        settings.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        contacts.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        find.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        emergency.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func formatControl(control: UIControl) {
        control.frame.size = CGSize(width: screenSize.width/2.5, height: screenSize.height/5)
        control.layer.cornerRadius = 10
    }
    
    func applyLabelFormat(label: UILabel) {
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        label.frame.size = CGSize(width: label.superview!.bounds.width, height: label.superview!.bounds.height)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.center = CGPoint(x: label.superview!.bounds.width/2, y: label.superview!.bounds.height/2)
    }
    
    func navigateToPage(sender: UIControl) {
        switch sender {
        case settings:
            println("Settings")
        case contacts:
            println("Contacts")
        case find:
            println("Find Hospital")
        case emergency:
            println("Emergency")
        default:
            break
        }
    }


}

