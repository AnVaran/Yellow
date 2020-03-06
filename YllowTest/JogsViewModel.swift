//
//  JogsViewModel.swift
//  YllowTest
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import UIKit

class JogsViewModel: NSObject {
    
    var jogs = [Jogs]()
    
    func fetchJogs(completion: @escaping () -> ()) {
        
        NetworkManager.fetchJogs { [weak self] (jogs) in
            self?.jogs = jogs
            completion()
        }
    }

    func cell(cell: TableViewCell, indexPath: IndexPath) {
        
        let jog = jogs[indexPath.row]

        cell.dateLable?.text = jog.date ?? "Date"
        cell.distanceLable?.text = String(jog.distance ?? 0) + " km"
        cell.speedLable?.text = String(Int(jog.distance ?? 0) / (jog.time ?? 1)) + " km/min"
        cell.timeLable?.text = String(jog.time ?? 0) + " min"
        
    }
    
    func numberOfRowsInSection() -> Int {
        return jogs.count
    }
    
}
