//
//  NetworkManager.swift
//  YllowTest
//
//  Created by Admin on 04/03/2020.
//  Copyright © 2020 Anton Varenik. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum Param {
    case log
    case add
    case show
    case feedback
    case fetchId
}

class NetworkManager {
    
    private static let serverUrl = "https://jogtracker.herokuapp.com"
    

    
    private static func url(_ param: Param) -> String {
    
        var newUrl = ""
        
        switch param {
        case .log:
            newUrl = serverUrl + "/api/v1/auth/uuidLogin"
            break
        case .add:
            newUrl = serverUrl + "/api/v1/data/jog"
            break
        case .show:
            newUrl = serverUrl + "/api/v1/data/sync"
            break
        case .feedback:
            newUrl = serverUrl + "/api/v1/feedback/send"
            break
        case .fetchId:
            newUrl = serverUrl + "/api/v1/auth/user"
            break
        default:
            print("Not avaibale name")
        }
        
        return newUrl
    }
    
    
    static func postLogin(uuid: String){
        
        let param = ["uuid" : "hello"]
        
        
        AF.request(url(.log), method: .post, parameters: param).validate().responseJSON { responseJSON in

        switch responseJSON.result {
        case .success(let value):
            guard let jsonObject = value as? [String: Any] else { return }
            
            guard let response = jsonObject["response"] as? [String : Any] else { return }
            
            guard let token = response["access_token"] as? String else { return }
            
            NetworkManager.fetchId(access_token: token)
            
        case .failure(let error):
            print(error)
        }
            
        }
    }
    
        static func fetchId(access_token: String) {
            
            let fetchUrl = url(.fetchId)
            
            let url = URL(string: fetchUrl)
            guard let requestUrl = url else { fatalError() }
       
            var request = URLRequest(url: requestUrl)
       
            request.addValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
            request.httpMethod = "GET"
        
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
            
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                }
            
            }
            task.resume()
        }
    
}
