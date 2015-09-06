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
    
    override func viewDidLoad() {
        api = RESTAPI()
        
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        tableView = UITableView(frame: CGRectMake(0, 20, view.frame.width, view.frame.height-20))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        api.apiCall(locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude) { (swiftyJSON) -> Void in
            self.hospitalData = swiftyJSON["data"]
            self.tableView.reloadData()
            self.view.addSubview(self.tableView)
        }
        
        self.navigationController?.navigationBarHidden = false
        
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
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalData.count
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
}