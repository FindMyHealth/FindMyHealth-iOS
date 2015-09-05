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
        let topView = UIView()
        topView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height * 0.15)
        topView.frame.origin = CGPointZero
        topView.backgroundColor = UIColor(hex: 0x008500, alpha: 1)
        view.addSubview(topView)
        
        let mainTitle = UILabel()
        mainTitle.textAlignment = .Center
        mainTitle.textColor = UIColor.whiteColor()
        mainTitle.font = UIFont(name: "HelveticaNeue", size: 30)
        mainTitle.text = "Choose Your Condition"
        mainTitle.sizeToFit()
        mainTitle.frame.size.width = view.bounds.width
        mainTitle.center = CGPoint(x: topView.bounds.midX, y: topView.bounds.midY)
        topView.addSubview(mainTitle)
        
        let titles:[String] = ["","","",""]
        let description:[String] = ["","","",""]
        let images:[UIImage] = []
        
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