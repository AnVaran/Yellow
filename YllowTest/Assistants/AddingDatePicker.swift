//
//  AddingDatePicker.swift
//  YllowTest
//
//  Created by Admin on 09/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation

class AddingDateOicker: UIText {
    
    static func addDatePicker(dateText: UITextField) {
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
}
