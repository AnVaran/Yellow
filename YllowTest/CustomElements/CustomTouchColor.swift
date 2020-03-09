//
//  CustomTouchColor.swift
//  YllowTest
//
//  Created by Admin on 08/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit


class CustomTouchColor: UIButton {

    var touchColor: UIColor = UIColor.clear {
            didSet {
                self.addTarget(self, action: Selector(("touchColor:")), for: .touchDown)
                func touchColor() {
                    self.setTitleColor(#colorLiteral(red: 0.4806142449, green: 0.8107122183, blue: 0.1228002384, alpha: 1), for: .highlighted)
                }
            }
    }
}
