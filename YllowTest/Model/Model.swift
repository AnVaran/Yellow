//
//  Model.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation

struct Jogs: Decodable {
    var date: String?
    var distance: Float?
    var id: Int?
    var time: Int?
    var user_id: String?
    
}

struct Access_token {
    var access_token: String?
}
