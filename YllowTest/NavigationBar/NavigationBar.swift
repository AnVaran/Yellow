//
//  NavigationBar.swift
//  YllowTest
//
//  Created by Admin on 02/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit


@objc protocol NavigationBarDelegate: class {
    @objc optional func menuAction()
    @objc optional func filterAction()
}

@IBDesignable
class NavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: NavigationBar.self)
        bundle.loadNibNamed("NavigationBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        delegate?.menuAction?()
    }
    
    
    @IBAction func filterButton(_ sender: UIButton) {
        delegate?.filterAction?()
    }
}
