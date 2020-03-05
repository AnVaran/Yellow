//
//  URLs.swift
//  YllowTest
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation



struct Url {
    
    private static let serverUrl = "https://jogtracker.herokuapp.com"
    
    static var logUrl = {
        return serverUrl + "/api/v1/auth/uuidLogin"
    }
    
    static var addUrl = {
        return serverUrl + "/api/v1/data/jog"
    }
    
    static var showUrl = {
        return serverUrl + "/api/v1/data/sync"
    }
    
    static var feedbackUrl = {
        return serverUrl + "/api/v1/feedback/send"
    }
    
    static var fetchIdUrl = {
        return serverUrl + "/api/v1/auth/user"
    }
    
}
