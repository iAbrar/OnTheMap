//
//  Client.swift
//  OnTheMap
//
//  Created by imac on 7/15/20.
//  Copyright © 2020 Abrar. All rights reserved.
//

import Foundation

class OTMClient {
    
    static let apiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let apiId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    
    struct Auth {
        static var accountId = 0
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        
        case login
        case studentsLocation
        
        var stringValue: String {
            switch self {
                
            case .login: return Endpoints.base + "/session"
                
            case .studentsLocation: return Endpoints.base + "/StudentLocation"
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //login request
    class func login(email: String, password: String, completion: @escaping (Error?) -> Void){
        
        var request = URLRequest(url: Endpoints.login.url)
        print(request)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */

            completion(nil)
        }
        
        task.resume()
    }
    
  
    class func getStudentsLocation( completion: @escaping (Locations, Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: Endpoints.studentsLocation.url) { data, response, error in
            
            guard let data = data else {
                print(error)
                return
            }
            
            do{
                let responseObject = try JSONDecoder().decode(Locations.self, from: data)
                completion(responseObject,nil)
                
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}

