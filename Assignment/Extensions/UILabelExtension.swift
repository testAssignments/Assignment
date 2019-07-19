//
//  UILabelExtension.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    func height(fromtext: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.frame.size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
