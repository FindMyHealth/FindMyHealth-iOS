//
//  API.swift
//  findmyhealth
//
//  Created by Haitham Maaieh on 9/5/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class RESTAPI {
    
    var url : String = "http://pennapps.jayravaliya.com/api/v0.1/hospitals"
    
    func apiCall(latitude : CLLocationDegrees, longitude : CLLocationDegrees, completion : (swiftyJSON:JSON) -> Void) {
        
        var swiftyJSON : JSON = []
        
        var payload = [
            "coordinates":"\(latitude),\(longitude)"
        ]
        
        Alamofire.request(.GET, "http://pennapps.jayravaliya.com/api/v0.1/hospitals", parameters: payload).responseJSON { (request, response, data, error) -> Void in
            if(error == nil) {
                if let responseData : AnyObject? = data {
                    swiftyJSON = JSON(responseData!)
                    completion(swiftyJSON:swiftyJSON)
                }
            }
            
        }
    
    }
    
    
}