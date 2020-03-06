//
//  InitialViewController.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    let uuid = UUID().uuidString
    
    @IBOutlet weak var navigationBar: NavigationBar!

    
   override func viewDidLoad() {
        super.viewDidLoad()

    NetworkManager.postLogin(uuid: "") { (token) in
        NetworkManager.fetchId(token: token)
    }
    
    
    navigationBar.delegate = self
    navigationBar.filterButton.isHidden = true
    
    }
    
    
    @IBAction func initialButton(_ sender: UIButton) {
    }
}

extension InitialViewController: NavigationBarDelegate {
    func menuAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
        self.present(menuViewController, animated: true, completion: nil)
        
        
    }
}
