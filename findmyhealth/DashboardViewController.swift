//
//  ViewController.swift
//  findmyhealth
//
//  Created by Haitham Maaieh on 9/5/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import UIKit
import CoreLocation

class DashboardViewController: UIViewController, CLLocationManagerDelegate {
    let screenSize = UIScreen.mainScreen().bounds.size
    let topBorder:CGFloat = 75
    let bottomBorder:CGFloat = 20
    let buffer:CGFloat = 30
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
        var locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        view.backgroundColor = UIColor.whiteColor()
        let topView = UIView()
        let bottomView = UIView()
        settings.removeFromSuperview()
        contacts.removeFromSuperview()
        find.removeFromSuperview()
        emergency.removeFromSuperview()
        let images:[UIImage] = [UIImage(named: "settings")!, UIImage(named: "contacts")!, UIImage(named: "hospital")!, UIImage(named: "ambulance")!]
        let subtitles:[String] = ["Based on your condition, find the best hospital to go to.","Dial 911 and notify your primary contacts of your location.","Set up your primary contacts to notify in the case of an emergency.","Edit your profile information and app settings."]
        
        formatControl(settings)
        formatControl(contacts)
        formatControl(find)
        formatControl(emergency)
        topView.frame.size = CGSize(width: screenSize.width, height: topBorder)
        topView.frame.origin = CGPointZero
        topView.backgroundColor = UIColor(hex: 0x34c6cd, alpha: 1)
        bottomView.frame.size = CGSize(width: screenSize.width, height: bottomBorder)
        bottomView.frame.origin = CGPoint(x: 0, y: screenSize.height - bottomBorder)
        bottomView.backgroundColor = UIColor.blackColor()
        var count = 0
        for image in images {
            let imageView = UIImageView()
            imageView.image = image
            imageView.frame.size = CGSize(width: settings.frame.size.width * 0.4, height: image.size.height / image.size.width * settings.frame.size.width * 0.4)
            switch count {
            case 0:
                imageView.tintColor = UIColor(hex: 0x006064, alpha: 1)
                settings.addSubview(imageView)
            case 1:
                imageView.tintColor = UIColor(hex: 0xa64d00, alpha: 1)
                imageView.frame.size = CGSize(width: imageView.bounds.width*0.9, height: imageView.bounds.height*0.9)
                contacts.addSubview(imageView)
            case 2:
                imageView.tintColor = UIColor(hex: 0x008500, alpha: 1)
                find.addSubview(imageView)
            case 3:
                imageView.tintColor = UIColor(hex: 0xa60000, alpha: 1)
                imageView.frame.size = CGSize(width: imageView.bounds.width*1.5, height: imageView.bounds.height*1.5)
                emergency.addSubview(imageView)
            default:
                break
            }
            imageView.center = CGPoint(x: settings.bounds.width/2, y: settings.bounds.height*0.1 + imageView.bounds.height/2)
            count++
        }
        count = 0
        
//        settings.layer.borderColor = UIColor(hex: 0xFF0000, alpha: 1).CGColor
//        contacts.layer.borderColor = UIColor(hex: 0xFF7400, alpha: 1).CGColor
//        find.layer.borderColor = UIColor(hex: 0x009999, alpha: 1).CGColor
//        emergency.layer.borderColor = UIColor(hex: 0x00CC00, alpha: 1).CGColor
        
        settings.layer.borderColor = UIColor(hex: 0x000000, alpha: 1).CGColor
        contacts.layer.borderColor = UIColor(hex: 0x000000, alpha: 1).CGColor
        find.layer.borderColor = UIColor(hex: 0x000000, alpha: 1).CGColor
        emergency.layer.borderColor = UIColor(hex: 0x000000, alpha: 1).CGColor
        
//        settings.center = CGPoint(x: view.bounds.minX + settings.bounds.width/2 + buffer/2, y: view.bounds.minY + topBorder + settings.bounds.height/2 + buffer/2)
//        contacts.center = CGPoint(x: view.bounds.maxX - contacts.bounds.width/2 - buffer/2, y: settings.center.y)
//        find.center = CGPoint(x: settings.center.x, y: settings.center.y + settings.bounds.height/2 + find.bounds.height/2 + buffer/2)
//        emergency.center = CGPoint(x: contacts.center.x, y: find.center.y)
        
        find.center = CGPoint(x: view.bounds.minX + find.bounds.width/2, y: view.bounds.minY + topBorder + find.bounds.height/2)
        emergency.center = CGPoint(x: view.bounds.maxX - emergency.bounds.width/2, y: find.center.y)
        contacts.center = CGPoint(x: find.center.x, y: find.center.y + find.bounds.height/2 + contacts.bounds.height/2)
        settings.center = CGPoint(x: emergency.center.x, y: contacts.center.y)
        
        let settingsLabel = UILabel()
        let contactsLabel = UILabel()
        let findLabel = UILabel()
        let emergencyLabel = UILabel()
        
        settingsLabel.text = "Edit Settings"
        contactsLabel.text = "Primary Contacts"
        findLabel.text = "Find My Health"
        emergencyLabel.text = "Emergency 911"
        
        view.addSubview(settings)
        view.addSubview(contacts)
        view.addSubview(find)
        view.addSubview(emergency)
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        let mainTitle = UILabel()
        mainTitle.textAlignment = .Center
        mainTitle.textColor = UIColor.whiteColor()
        mainTitle.font = UIFont(name: "HelveticaNeue", size: 30)
        mainTitle.text = "Find My Health"
        mainTitle.sizeToFit()
        mainTitle.frame.size.width = screenSize.width
        mainTitle.frame.origin = CGPoint(x: 0, y: topView.bounds.maxY - mainTitle.frame.size.height*1.2)
        topView.addSubview(mainTitle)
        
        settings.addSubview(settingsLabel)
        contacts.addSubview(contactsLabel)
        find.addSubview(findLabel)
        emergency.addSubview(emergencyLabel)
        
        applyLabelFormat(settingsLabel)
        applyLabelFormat(contactsLabel)
        applyLabelFormat(findLabel)
        applyLabelFormat(emergencyLabel)
        
        for text in subtitles {
            let label = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.font = UIFont(name: "HelveticaNeue", size: 12)
            label.textAlignment = .Center
            label.textColor = UIColor.grayColor()
            label.frame.size.width = settings.frame.size.width - 10
            label.sizeToFit()
            switch count {
            case 0:
                label.center = CGPoint(x: find.bounds.width/2, y: find.bounds.height*0.65)
                find.addSubview(label)
            case 1:
                label.center = CGPoint(x: emergency.bounds.width/2, y: emergency.bounds.height*0.65)
                emergency.addSubview(label)
            case 2:
                label.center = CGPoint(x: contacts.bounds.width/2, y: contacts.bounds.height*0.65)
                contacts.addSubview(label)
            case 3:
                label.center = CGPoint(x: settings.bounds.width/2, y: settings.bounds.height*0.65)
                settings.addSubview(label)
            default:
                break
            }
            count++
        }
        
        
        settings.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        contacts.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        find.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        emergency.addTarget(self, action: "navigateToPage:", forControlEvents: UIControlEvents.TouchUpInside)
        settings.addTarget(self, action: "controlHighlight:", forControlEvents: UIControlEvents.TouchDown)
        contacts.addTarget(self, action: "controlHighlight:", forControlEvents: UIControlEvents.TouchDown)
        find.addTarget(self, action: "controlHighlight:", forControlEvents: UIControlEvents.TouchDown)
        emergency.addTarget(self, action: "controlHighlight:", forControlEvents: UIControlEvents.TouchDown)
        settings.addTarget(self, action: "controlNormal:", forControlEvents: UIControlEvents.TouchUpOutside)
        contacts.addTarget(self, action: "controlNormal:", forControlEvents: UIControlEvents.TouchUpOutside)
        find.addTarget(self, action: "controlNormal:", forControlEvents: UIControlEvents.TouchUpOutside)
        emergency.addTarget(self, action: "controlNormal:", forControlEvents: UIControlEvents.TouchUpOutside)
    }
    
    func formatControl(control: UIControl) {
//        control.frame.size = CGSize(width: screenSize.width/2 - buffer, height: (screenSize.height - topBorder - bottomBorder)/2 - buffer)
//        control.layer.cornerRadius = 20
        control.frame.size = CGSize(width: screenSize.width/2, height: (screenSize.height - topBorder - bottomBorder)/2)
        control.backgroundColor = UIColor.clearColor()
        control.layer.borderWidth = 0.5
    }
    
    func applyLabelFormat(label: UILabel) {
        label.textColor = UIColor(CGColor: label.superview!.layer.borderColor)
        label.textAlignment = .Center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.frame.size = CGSize(width: label.superview!.bounds.width, height: label.superview!.bounds.height)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.center = CGPoint(x: label.superview!.bounds.width/2, y: label.superview!.bounds.height/2)
    }
    
    func navigateToPage(sender: UIControl) {
        sender.alpha = 1
        switch sender {
        case settings:
            println("Settings")
            self.performSegueWithIdentifier("goToSettings", sender: self)
        case contacts:
            println("Contacts")
            self.performSegueWithIdentifier("goToContacts", sender: self)
        case find:
            println("Find Hospital")
            self.performSegueWithIdentifier("goToHospital", sender: self)
        case emergency:
            println("Emergency")
            self.performSegueWithIdentifier("goToEmergency", sender: self)
        default:
            break
        }
    }
    func controlHighlight(sender: UIControl) {
        sender.alpha = 0.5
    }
    func controlNormal(sender: UIControl) {
        sender.alpha = 1
    }
    func findLastY(view: UIView) -> CGFloat {
        var lastY:CGFloat = 0
        for views in view.subviews {
            let yEdge = (views.center.y + views.bounds.height/2)
            if(yEdge > lastY) {
                lastY = yEdge
            }
        }
        return lastY
    }

}

