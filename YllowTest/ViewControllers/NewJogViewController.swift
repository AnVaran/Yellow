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
    
    var currentJog: Jogs!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var distanceText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonIsAnenabled()
        
        navigationBar.delegate = self
        navigationBar.filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        
        dateText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        dateText.addTarget(self, action: #selector(textFieldIsActive), for: .editingDidBegin)
        dateText.addTarget(self, action: #selector(textFieldIsUnactive), for: .editingDidEnd)

        addDatePicker()
        
        setUpEditScreen()
    }
    
    private func saveButtonIsEnabled() {
        saveButton.isEnabled = true
        saveButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        saveButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .disabled)
    }
    
    private func saveButtonIsAnenabled() {
        saveButton.isEnabled = false
        saveButton.layer.borderColor = #colorLiteral(red: 0.2980392157, green: 0.5215686275, blue: 0.05882352941, alpha: 1)
        saveButton.setTitleColor(#colorLiteral(red: 0.2980392157, green: 0.5215686275, blue: 0.05882352941, alpha: 1), for: .disabled)
    }
    
    private func setUpEditScreen() {
        if currentJog != nil {
            
            dateText.text = currentJog.date
            distanceText.text = String(currentJog.distance ?? 0)
            timeText.text = String(currentJog.time ?? 0)
            saveButtonIsEnabled()
            datePicker.date = FormatterDate.StringToDate(getString: currentJog.date ?? "")
        }
    }
    
    private func addDatePicker() {
        dateText.inputView = datePicker
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        
        dateText.inputAccessoryView = toolBar
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    
        let maxDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        datePicker.maximumDate = maxDate
    }
    
    @objc func doneAction() {
        view.endEditing(true)
    }
    
    @objc func dateChange() {
        getDateFromPicker()
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateText.text = formatter.string(from: datePicker.date)
        saveButtonIsEnabled()
    }
    
    func saveJog() {
        if currentJog != nil {
            
            NetworkManager.changeJog(date: dateText.text ?? "",
                                     time: Int(timeText.text ?? "") ?? 0,
                                     distance: Float(distanceText.text ?? "") ?? 0,
                                     jog_id: currentJog.id!)
        } else {
            let newDateString = FormatterDate.StringToSttring(dateText.text!)
            NetworkManager.addJog(date: newDateString,
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
    
    @objc private func textFieldChanged() {
        
           if dateText.text?.isEmpty == false {
                saveButtonIsEnabled()
           } else {
                saveButtonIsAnenabled()
                
           }
    }
    @objc private func textFieldIsActive() {
        
        topConstraint.constant = 48
    }

    @objc private func textFieldIsUnactive() {
        
        topConstraint.constant = 82
    }
}
