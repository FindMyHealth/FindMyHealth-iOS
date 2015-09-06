//
//  SortedHospitalsViewController.swift
//  findmyhealth
//
//  Created by Jay Ravaliya on 9/6/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class SortedHospitalsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var tableView : UITableView!
    var api : RESTAPI!
    let locationManager = CLLocationManager()
    var hospitalData : JSON = []
    var activityIndicator : UIActivityIndicatorView!
    var button : UIButton!
    
    override func viewDidLoad() {
        api = RESTAPI()
        
        var width = UIScreen.mainScreen().bounds.width
        var height = UIScreen.mainScreen().bounds.height
        
        button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        button.frame = CGRectMake(width/2-30, 20, 60, 45)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.setTitle("Back", forState: UIControlState.Normal)
        button.addTarget(self, action: "back:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(width/2-20, height/2-20, 40, 40))
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.color = UIColor.blackColor()
        view.addSubview(activityIndicator)
        
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        tableView = UITableView(frame: CGRectMake(0, 50, view.frame.width, view.frame.height-50))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        api.apiCall(locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude) { (swiftyJSON) -> Void in
            self.hospitalData = swiftyJSON["data"]
            self.tableView.reloadData()
            self.view.addSubview(self.tableView)
            self.activityIndicator.alpha = 0
            self.activityIndicator.stopAnimating()
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue cell and set style to Subtitle
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = hospitalData[indexPath.row]["name"].stringValue
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
        cell.detailTextLabel?.text = "See an ER doctor in " + hospitalData[indexPath.row]["total_time"].stringValue + " min"
        
        // cell.detailTextLabel?.text = "Total Time: " + hospitalData[indexPath.row]["total_time"].stringValue + " / Wait Time: " + hospitalData[indexPath.row]["wait_time"].stringValue + " / Drive Time " + hospitalData[indexPath.row]["drive_time"].stringValue
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // creating an action sheet
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Options", message: "Select an option below.", preferredStyle: .ActionSheet)
        
        //Create and add first option action
        let openGoogleMaps: UIAlertAction = UIAlertAction(title: "Navigate", style: .Default) { action -> Void in
            
            // create string, replace spaces with "+" symbols
            
            var query = self.hospitalData[indexPath.row]["name"].stringValue + ",+" + self.hospitalData[indexPath.row]["address"].stringValue
            query = query.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            // create url and altUrl  - url opens up the Google Maps app, altUrl opens up the directions in a web browser
            var url = "comgooglemaps://?q=" + query
            var altUrl = "https://www.maps.google.com/?q=" + query
            
            // if the user has the app installed, it will open the address within it.
            if UIApplication.sharedApplication().canOpenURL(NSURL(string: url)!) == true
            {
                UIApplication.sharedApplication().openURL(NSURL(string: url)!)
            }
            else
            {
                UIApplication.sharedApplication().openURL(NSURL(string: altUrl)!)
            }
            
        }
        // add Google Maps to the actionSheet
        actionSheetController.addAction(openGoogleMaps)
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalData.count
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
    
    func back(sender : UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}