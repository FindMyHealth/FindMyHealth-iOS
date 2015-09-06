//
//  EmergencyViewController.swift
//  findmyhealth
//
//  Created by Haitham Maaieh on 9/5/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import CoreLocation

class EmergencyViewController: UIViewController, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setUpInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let locationManager = CLLocationManager()
    let screenSize = UIScreen.mainScreen().bounds
    var timer = NSTimer()
    var count = 3
    var timeLabel = UILabel()
    var circleView = CircleView()
    let innerCircle = UIControl()

    func setUpInterface() {
        innerCircle.removeFromSuperview()
        let topView = UIView()
        topView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height * 0.15)
        topView.frame.origin = CGPointZero
        topView.backgroundColor = UIColor(hex: 0xa60000, alpha: 1)
        view.addSubview(topView)
        let mainTitle = UILabel()
        mainTitle.textAlignment = .Center
        mainTitle.textColor = UIColor.whiteColor()
        mainTitle.font = UIFont(name: "HelveticaNeue", size: 30)
        mainTitle.text = "911 Emergency"
        mainTitle.sizeToFit()
        mainTitle.frame.size.width = view.bounds.width
        mainTitle.center = CGPoint(x: topView.bounds.midX, y: topView.bounds.midY)
        topView.addSubview(mainTitle)
        let bottomView = UIView()
        bottomView.frame.size = CGSize(width: screenSize.width, height: 70)
        bottomView.frame.origin = CGPoint(x: 0, y: view.bounds.maxY - bottomView.bounds.height)
        view.addSubview(bottomView)
        let backButton = UIButton()
        backButton.setTitle("CANCEL", forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor(hex: 0x00cc00, alpha: 1)
        backButton.layer.cornerRadius = 5
        backButton.sizeToFit()
        backButton.frame.size.width *= 1.1
        backButton.frame.size.height *= 1.1
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.center = CGPoint(x: bottomView.bounds.midX, y: bottomView.bounds.midY)
        bottomView.addSubview(backButton)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        
        let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
        var circleWidth = CGFloat(200)
        var circleHeight = circleWidth
        circleView = CircleView(frame: CGRectMake(diceRoll, 0, circleWidth, circleHeight))
        circleView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.addSubview(circleView)
        
        innerCircle.backgroundColor = UIColor(hex: 0xa60000, alpha: 1)
        innerCircle.frame.size = CGSize(width: circleWidth - 35, height: circleHeight - 35)
        innerCircle.layer.cornerRadius = innerCircle.frame.size.height/2
        innerCircle.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        innerCircle.addTarget(self, action: "startTimer", forControlEvents: UIControlEvents.TouchDown)
        innerCircle.addTarget(self, action: "cancelTimer", forControlEvents: UIControlEvents.TouchUpInside)
        innerCircle.addTarget(self, action: "cancelTimer", forControlEvents: UIControlEvents.TouchUpOutside)

        view.addSubview(innerCircle)
        
        timeLabel = UILabel()
        timeLabel.text = "Hold Down \n to Call \n 911"
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.textAlignment = .Center
        timeLabel.frame.size = innerCircle.frame.size
        timeLabel.frame.origin = CGPointZero
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        timeLabel.numberOfLines = 0
        innerCircle.addSubview(timeLabel)
    }
    
    func cancelTimer() {
        count = 3
        timer.invalidate()
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        timeLabel.text = "Hold Down \n to Call \n 911"
        circleView.removeFromSuperview()
        let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
        var circleWidth = CGFloat(200)
        var circleHeight = circleWidth
        circleView = CircleView(frame: CGRectMake(diceRoll, 0, circleWidth, circleHeight))
        circleView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.addSubview(circleView)
        view.bringSubviewToFront(innerCircle)
    }
    
    func startTimer() {
        timeLabel.text = String(count)
        timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        circleView.animateCircle(3.0)
    }
    
    func updateCounter() {
        timeLabel.text = String(count--)
        if(count <= 0) {
            cancelTimer()
            timeLabel.text = "Calling \n 911"
            timeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
            call911()
        }
    }

    func addTimer() {
        let timerLabel = UILabel()
        
    }
    
    func call911() {
        var url:NSURL = NSURL(string: "tel://911")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        //Do What ever you want with it
        sendText(lat, long: long)
    }
    
    func sendText(lat: CLLocationDistance, long: CLLocationDistance) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "The person with this number has indicated he is in an emergency situation using the Find My Health App. You have been listed as his primary contact. His location is approximately: {\(lat), \(long)}."
            controller.recipients = ["9738967552"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
}