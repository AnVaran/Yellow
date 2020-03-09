//
//  MenuViewController.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var jogsButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func jogsButton(_ sender: UIButton) {
       
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
    }
    
    @IBAction func contactButton(_ sender: UIButton) {
    }
    
    

}
