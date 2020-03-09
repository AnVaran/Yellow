//
//  CustomTextField.swift
//  YllowTest
//
//  Created by Admin on 08/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {

    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = cornerRadius
            }
    }

}
