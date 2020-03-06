//
//  Protocols.swift
//  YllowTest
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation
 
protocol JogsViewModelDelegate: class {
    func fetchData(jogs: [Jogs])
}
