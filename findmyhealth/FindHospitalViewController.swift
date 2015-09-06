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
    
    let screenSize = UIScreen.mainScreen().bounds
    
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
        
        let controls:[UIControl] = [UIControl(), UIControl(), UIControl(), UIControl()]
        let titles:[String] = ["Broken Bones","CT Scan","Pregnant","Other"]
        let description:[String] = ["Description text here.","Description text here.","Description text here.","Description text here."]
        let images:[UIImage] = [UIImage(named: "broken_bones")!, UIImage(named: "ct_scan")!, UIImage(named: "pregnant")!, UIImage(named: "other")!]
        let height: CGFloat = (screenSize.height - topView.frame.size.height)/CGFloat(titles.count)
        
        for i in 0...titles.count - 1 {
            controls[i].frame.size = CGSize(width: screenSize.width, height: height)
            controls[i].frame.origin = CGPoint(x: 0, y: CGFloat(i)*height + topView.bounds.height)
            controls[i].addTarget(self, action: "navigate:", forControlEvents: .TouchUpInside)
            controls[i].addTarget(self, action: "touchDown:", forControlEvents: .TouchDown)
            controls[i].addTarget(self, action: "touchUpOutside:", forControlEvents: .TouchUpOutside)
            view.addSubview(controls[i])
            
            let icon = UIImageView()
            icon.frame.size = CGSize(width: controls[i].frame.size.height * 0.6, height: controls[i].frame.size.height * 0.6)
            icon.image = images[i]
            icon.center = CGPoint(x: controls[i].bounds.minX + icon.bounds.width * 1.5, y: controls[i].bounds.midY)
            controls[i].addSubview(icon)
            
            
        }
        
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