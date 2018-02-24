//
//  UIColor+Extension.swift
//  Airabela
//
//  Created by Alen Kirm on 12. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let airabelaBlue = UIColor.rgb(red: 0, green: 134, blue: 222)
    
    static let airabelaGray = UIColor.rgb(red: 243, green: 243, blue: 243)
}
