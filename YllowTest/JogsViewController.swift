//
//  JogsViewController.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class JogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var navigationBar: NavigationBar!
    
    @IBOutlet var viewModel: JogsViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var sadLable: UILabel!
    @IBOutlet weak var firstJog: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
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
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newJogVC = segue.source as? NewJogViewController else { return }
        newJogVC.saveJog()
        tableView.reloadData()
        
    }
    
    @IBAction func cancelSegue(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func addJog(_ sender: UIButton) {
        performSegue(withIdentifier: "addJog", sender: self)
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
       return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        viewModel.cell(cell: cell, indexPath: indexPath) 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let jog = viewModel.jogs[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "delete") {
            (_, _) in
            guard let jog_id = jog.id else { return }
            NetworkManager.deleteJog(jog_id: jog_id)
            self.viewModel.jogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return [deleteAction]
    }
}

extension JogsViewController: NavigationBarDelegate {
    func menuAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
        self.present(menuViewController, animated: true, completion: nil)
    }
}
