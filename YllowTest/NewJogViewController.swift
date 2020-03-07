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
    
    @IBOutlet weak var upView: UIView!
    
    var currentJog: Jogs!
    
    
    @IBOutlet weak var distanceText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        navigationBar.delegate = self
        navigationBar.filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        
        setUpEditScreen()
    }
   
    private func setUpEditScreen() {
        if currentJog != nil {
            
            dateText.text = currentJog.date
            distanceText.text = String(currentJog.distance ?? 0)
            timeText.text = String(currentJog.time ?? 0)
        }
    }
    
    func saveJog() {
        if currentJog != nil {
            NetworkManager.changeJog(date: dateText.text ?? "",
                                     time: Int(timeText.text ?? "") ?? 0,
                                     distance: Float(distanceText.text ?? "") ?? 0,
                                     jog_id: currentJog.id!)
        } else {
            NetworkManager.addJog(date: dateText.text ?? "",
                                  time: Int(timeText.text ?? "") ?? 0,
                                  distance: Float(distanceText.text ?? "") ?? 0)
        }
        
    }
    
}

extension NewJogViewController: NavigationBarDelegate {
func menuAction() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
    self.present(menuViewController, animated: true, completion: nil)
    }
}

extension NewJogViewController: UITextFieldDelegate {
       // Hide keybourd for tap  on DONE
       
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }

}
