//
//  JogsViewController.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let datePickerTo = UIDatePicker()
    let datePickerFrom = UIDatePicker()
    private var filteredJogs = [Jogs]()
    
    
    
    private var isFiltering: Bool = false
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet var viewModel: JogsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var sadLable: UILabel!
    @IBOutlet weak var firstJog: CustomButton!

    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        addDatePicker(dateText: dateToTextField, datePicker: datePickerTo)
        addDatePicker(dateText: dateFromTextField, datePicker: datePickerFrom)
        
        
        navigationBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getData() {
        viewModel.fetchJogs { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func addDatePicker(dateText: UITextField, datePicker: UIDatePicker){
           dateText.inputView = datePicker
           datePicker.datePickerMode = .date
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           
           toolBar.setItems([flexSpace, doneButton], animated: true)
           
           dateText.inputAccessoryView = toolBar
            if dateText == dateToTextField {
                datePicker.addTarget(self, action: #selector(dateToTextFieldChange), for:   .valueChanged)
            } else if dateText == dateFromTextField {

                datePicker.addTarget(self, action: #selector(dateFromTextFieldChange), for: .valueChanged)
            }
            let maxDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
            datePicker.maximumDate = maxDate
    }
       
       @objc func doneAction() {
           view.endEditing(true)
       }
       
       @objc func dateToTextFieldChange() {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy"
           dateToTextField.text = formatter.string(from: datePickerTo.date)
       }
    
       @objc func dateFromTextFieldChange() {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            dateFromTextField.text = formatter.string(from: datePickerFrom.date)
        }
    
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newJogVC = segue.source as? NewJogViewController else { return }
        newJogVC.saveJog()
        
    }
    
    @IBAction func cancelSegue(_ segue: UIStoryboardSegue) {
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeJog" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let jog = viewModel.jogs[indexPath.row]
            let newJogVC = segue.destination as! NewJogViewController
            newJogVC.currentJog = jog
            
        }
        
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFiltering {
            return filteredJogs.count
        }
       return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        viewModel.cell(cell: cell, indexPath: indexPath, filterJog: filteredJogs, isFiltering: isFiltering)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let jog = isFiltering ? filteredJogs[indexPath.row] : viewModel.jogs[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "delete") {
            (_, _) in
            guard let jog_id = jog.id else { return }
            NetworkManager.deleteJog(jog_id: jog_id)
            self.viewModel.jogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
    
    private func search() {
        for jog in viewModel.jogs {
            if jog.date! >= dateFromTextField.text! && jog.date! <= dateToTextField.text! {
                filteredJogs.append(jog)
            }
        }
        print(filteredJogs)
        tableView.reloadData()
    
    }
}

extension JogsViewController: NavigationBarDelegate {
    func menuAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
        self.present(menuViewController, animated: true, completion: nil)
    }
    
    func filterAction() {
        
        isFiltering = true
        
        for jog in viewModel.jogs {
            if jog.date! >= dateFromTextField.text! && jog.date! <= dateToTextField.text! {
                filteredJogs.append(jog)
            }
        }
        isFiltering = false
        print(filteredJogs)
        tableView.reloadData()
        
        
    }
}
