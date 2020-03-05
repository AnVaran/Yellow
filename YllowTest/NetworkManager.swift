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



class NetworkManager: NSObject {
    
    
    static private var id: String?
    static private var access_token: String?

    
    
    
    static func postLogin(uuid: String){
        
        let param = ["uuid" : "hello"]
        
        
        AF.request(Url.logUrl(), method: .post, parameters: param).validate().responseJSON { responseJSON in

        switch responseJSON.result {
        case .success(let value):
            guard let jsonObject = value as? [String: Any] else { return }
            
            guard let response = jsonObject["response"] as? [String : Any] else { return }
            
            guard let token = response["access_token"] as? String else { return }
            
            access_token = token
            
            NetworkManager.fetchId(access_token: access_token ?? "")
            NetworkManager.fetchJogs { (a) in
            
            }
        case .failure(let error):
            print(error)
        }
            
        }
    }
    
        static func fetchId(access_token: String) {
            
            let fetchUrl = Url.fetchIdUrl()
            
            let url = URL(string: fetchUrl)
            guard let requestUrl = url else { fatalError() }
       
            var request = URLRequest(url: requestUrl)
       
            request.addValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        
            request.httpMethod = "GET"
        
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let jsonObject = json as? [String : Any] else { return }
                    
                    guard let response = jsonObject["response"] as? [String : Any] else { return }
                    
                    guard let id = response["id"] as? String else { return }
                    self.id = id
                    
                    
                } catch {
                    print(error)
                }
                
            
            }
            task.resume()
        }
    
    static func fetchJogs(completion: @escaping ([Jogs])->()) {
        let fetchUrl = Url.showUrl()
        let url = URL(string: fetchUrl)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.addValue("Bearer \(access_token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
         
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else { return }
                 
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonObject = json as? [String : Any] else { return }
                guard let resp = jsonObject["response"] as? [String : Any] else { return }
                guard let array = resp["jogs"] as? Array<[String : Any]> else { return }
                   
                var jogs = [Jogs]()
                    
                for field in array {

                    let jog = Jogs(date: field["date"] as? String,
                                    distance: field["distance"] as? Float,
                                    id: field["id"] as? Int,
                                    time: field["time"] as? Int,
                                    user_id: field["user_id"] as? String)
                    
                    if jog.user_id == self.id {
                        jogs.append(jog)
                    }
                    
                }
                print(jogs)
                
                completion(jogs)
                     
                 } catch {
                     print(error)
                 }
                 
             
             }
             task.resume()
    }
}


