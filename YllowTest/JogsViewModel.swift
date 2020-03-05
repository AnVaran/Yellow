//
//  JogsViewModel.swift
//  YllowTest
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class JogsViewModel: NSObject {


    private var jogs: [Jogs]?
    
    
    func fetchJogs(completion: @escaping ()->()) {
        
        NetworkManager.fetchJogs { (jogs) in
            
            self.jogs = jogs
            //print("\(jogs) ih")
            completion()
            
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return jogs?.count ?? 0
    }
    
}
