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

class EmergencyViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let screenSize = UIScreen.mainScreen().bounds
    
    func setUpInterface() {
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
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.center = CGPoint(x: bottomView.bounds.midX, y: bottomView.bounds.midY)
        bottomView.addSubview(backButton)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        
        addCircleView()
        
    }
    
    func addCircleView() {
        let diceRoll = CGFloat(Int(arc4random_uniform(7))*50)
        var circleWidth = CGFloat(200)
        var circleHeight = circleWidth
        
        // Create a new CircleView
        var circleView = CircleView(frame: CGRectMake(diceRoll, 0, circleWidth, circleHeight))
        circleView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.addSubview(circleView)
        circleView.animateCircle(5.0)
    }
    func addTimer() {
        let timerLabel = UILabel()
        
    }
    
    func call911() {
        var url:NSURL = NSURL(string: "tel://911")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    func back() {
        sendText()
//        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        println("lat: \(lat), long: \(long)")
        //Do What ever you want with it
    }
    
    func sendText() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["9738967552"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
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