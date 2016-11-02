//
//  UIButton+Extension.swift
//  SinaWeb(Swift)
//
//  Created by cyz on 16/11/2.
//  Copyright © 2016年 yuze. All rights reserved.
//

import UIKit

extension UIButton
{
    convenience init(imageName:String, backgroundImageName: String, state: UIControlState) {
        self.init()
        self.setImage(UIImage.init(named: imageName), for: state)
        self.setBackgroundImage(UIImage.init(named: backgroundImageName), for: state)
    }
}
