//
//  NewJogViewController.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class NewJogViewController: UIViewController {
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet weak var distanceText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationBar.delegate = self
        navigationBar.filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
    }
   
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveJog(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
}

extension NewJogViewController: NavigationBarDelegate {
func menuAction() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
    self.present(menuViewController, animated: true, completion: nil)
    }
}
