//
//  UIImageView.swift
//  Assignment
//
//  Created by test on 17/07/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
    func downloadImageFrom(link: String, contentMode: UIView.ContentMode) {
        if self.image == nil {
            self.image = UIImage()
        }
        URLSession.shared.dataTask( with: NSURL(string: link)! as URL,
                                    completionHandler: { (data, _ response, _ error) -> Void in
                                        DispatchQueue.main.async {
                                            self.contentMode =  contentMode
                                            if let data = data { self.image = UIImage(data: data) }
                                        }
        }).resume()
    }
}
