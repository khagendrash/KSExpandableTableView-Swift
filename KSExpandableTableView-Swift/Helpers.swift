//
//  Helpers.swift
//  KSExpandableTableView-Swift
//
//  Created by Mac on 3/20/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation
import UIKit

class Helpers{
    
    class func getArrow(_ arrowType:String) -> UIImageView{
    
        let ivArrow: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 18, height: 18))
        ivArrow.image = UIImage.init(named: "arrow-down")
        
        if arrowType == "up"{
            ivArrow.image = UIImage.init(named: "arrow-up")
        }
        
        return ivArrow
    }
    
    // set the backgroud color for status bar
    class func setStatusBarBackgroundColor(){
        let statusBar = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
}
