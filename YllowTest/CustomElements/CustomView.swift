//
//  CustomView.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {

    
    
   @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
            self.layer.cornerRadius = cornerRadius
            }
    }

}
