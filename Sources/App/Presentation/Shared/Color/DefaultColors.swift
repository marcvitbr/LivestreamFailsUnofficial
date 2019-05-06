//
//  DefaultColors.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 01/05/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import UIKit

extension UIColor {
    class func themeBackgroundColor() -> UIColor {
        return UIColor(red: 18/255, green: 27/255, blue: 34/255, alpha: 1)
    }

    class func themeLikeButtonColor() -> UIColor {
        return UIColor(red: 253/255, green: 160/255, blue: 68/255, alpha: 1)
    }
}

extension UIColor {
    class func random() -> UIColor {
        let range: ClosedRange<CGFloat> = 0...1

        return UIColor(red: CGFloat.random(in: range),
                       green: CGFloat.random(in: range),
                       blue: CGFloat.random(in: range),
                       alpha: 1)
    }
}
