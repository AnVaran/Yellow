//
//  CreateFirstJogButton.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
            didSet {
            self.layer.cornerRadius = cornerRadius
            }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
            didSet {
                self.layer.borderWidth = borderWidth
            }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
            didSet {
                self.layer.borderColor = borderColor.cgColor
            }
    }
    
}
