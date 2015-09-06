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
    let controls:[UIControl] = [UIControl(), UIControl(), UIControl(), UIControl()]

    func setUpInterface() {
        let topView = UIView()
        topView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.height * 0.15)
        topView.frame.origin = CGPointZero
        topView.backgroundColor = UIColor(hex: 0x34c6cd, alpha: 1)
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
        let bottomView = UIView()
        bottomView.frame.size = CGSize(width: screenSize.width, height: 70)
        bottomView.frame.origin = CGPoint(x: 0, y: view.bounds.maxY - bottomView.bounds.height)
        view.addSubview(bottomView)
        let backButton = UIButton()
        backButton.setTitle("BACK", forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor(hex: 0x00cc00, alpha: 1)
        backButton.layer.cornerRadius = 5
        backButton.sizeToFit()
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.center = CGPoint(x: bottomView.bounds.midX, y: bottomView.bounds.midY)
        bottomView.addSubview(backButton)
        backButton.addTarget(self, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
        
        let titles:[String] = ["Broken Bones","CT Scan","Pregnant","Other"]
        let description:[String] = ["Description text here.","Description text here.","Description text here.","Description text here."]
        let images:[UIImage] = [UIImage(named: "broken_bones")!, UIImage(named: "ct_scan")!, UIImage(named: "pregnant")!, UIImage(named: "other")!]
        let height: CGFloat = (screenSize.height - topView.frame.size.height - bottomView.frame.size.height)/CGFloat(titles.count)
        
        for i in 0...titles.count - 1 {
            controls[i].frame.size = CGSize(width: screenSize.width, height: height)
            controls[i].frame.origin = CGPoint(x: 0, y: CGFloat(i)*height + topView.bounds.height)
            controls[i].addTarget(self, action: "navigate:", forControlEvents: .TouchUpInside)
            controls[i].addTarget(self, action: "touchDown:", forControlEvents: .TouchDown)
            controls[i].addTarget(self, action: "touchUpOutside:", forControlEvents: .TouchUpOutside)
            controls[i].layer.borderColor = UIColor.blackColor().CGColor
            controls[i].layer.borderWidth = 1
            view.addSubview(controls[i])
            
            let icon = UIImageView()
            icon.frame.size = CGSize(width: controls[i].frame.size.height * 0.4, height: controls[i].frame.size.height * 0.4)
            icon.image = images[i]
            icon.center = CGPoint(x: controls[i].bounds.minX + icon.bounds.width/2 + 25, y: controls[i].bounds.midY)
            controls[i].addSubview(icon)
            
            let title = UILabel()
            title.text = titles[i]
            title.textColor = UIColor.blackColor()
            title.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
            title.textAlignment = .Center
            title.sizeToFit()
            title.center = CGPoint(x: icon.center.x + icon.bounds.width/2 + title.bounds.width/2 + 25, y: icon.center.y - icon.bounds.height/2 + title.bounds.height/2)
            controls[i].addSubview(title)
            
            let descLabel = UILabel()
            descLabel.text = description[i]
            descLabel.textColor = UIColor.grayColor()
            descLabel.font = UIFont(name: "HelveticaNeue", size: 13)
            descLabel.frame.size.width = controls[i].frame.size.width * 0.3
            descLabel.numberOfLines = 0
            descLabel.lineBreakMode = .ByWordWrapping
            descLabel.sizeToFit()
            descLabel.frame.origin = CGPoint(x: title.frame.origin.x, y: title.center.y + title.bounds.height/2 + 10)
            controls[i].addSubview(descLabel)
        }
    }
    
    func navigate(sender: UIControl) {
        sender.alpha = 1
        switch sender {
        case controls[0]:
            println("broken bones")
        case controls[1]:
            println("ct scan")
        case controls[2]:
            println("pregnant")
        case controls[3]:
            println("other")
        default:
            break
        }
    }
    
    func touchDown(sender: UIControl) {
        sender.alpha = 0.5
    }
    
    func touchUpOutside(sender: UIControl) {
        sender.alpha = 1
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}