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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sadImage: UIImageView!
    @IBOutlet weak var sadLable: UILabel!
    @IBOutlet weak var firstJog: CustomButton!
    
    @IBOutlet weak var addJog: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "changeJog" else { return }
        guard let destination = segue.destination as? NewJogViewController else { return }
        
    }
    
    @IBAction func firstJog(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newJog", sender: self)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newJog", sender: self)
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        return cell
    }
}

extension JogsViewController: NavigationBarDelegate {
    func menuAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController = storyboard.instantiateViewController(identifier: "menuViewController") as! MenuViewController
        self.present(menuViewController, animated: true, completion: nil)
    }
}
