//
//  FindHospitalViewController.swift
//  findmyhealth
//
//  Created by Haitham Maaieh on 9/5/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import Foundation
import UIKit

class FindHospitalViewController: UIViewController {
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
        let backButton = UIButton()
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.sizeToFit()
        backButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        backButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.maxY - backButton.bounds.height/2 - 50)
        view.addSubview(backButton)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}