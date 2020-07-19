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
    class func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(false,error)
                return
            }
            
            do {
                
                let range = Range(5..<data.count)
                let newData = data.subdata(in: range) /* subset response data! */
                let responseObject = try JSONDecoder().decode(LoginResponse.self, from: newData)
                print(String(data: newData, encoding: .utf8)!)
                Auth.sessionId = responseObject.session.id
                completion(true,nil)
            }catch {
                completion(false,error)
            }
        }
        task.resume()
    }
    
    //    class func getStudentsLocation( completion: @escaping (Bool, Error?) -> Void){
    //
    //        let task = URLSession.shared.dataTask(with: Endpoints.studentsLocation.url) { data, response, error in
    //            guard let data = data else {
    //                completion(false, error)
    //                return
    //            }
    //            let decoder = JSONDecoder()
    //            do {
    //                print(data)
    //                completion(true, nil)
    //            } catch {
    //                completion(false, error)
    //            }
    //        }
    //        task.resume()
    //    }
    
    class func getStudentsLocation( completion: @escaping (Locations?, Error?) -> Void){
        //        let request = URLRequest(url: URL(string: Endpoints.studentsLocation.url)!)
        //        let session = URLSession.shared
        let task = URLSession.shared.dataTask(with: Endpoints.studentsLocation.url) { data, response, error in
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do{
                
                let responseObject = try JSONDecoder().decode(Locations.self, from: data)
                completion(responseObject,nil)
                
            }catch{
                completion(nil,error)
                
            }
            
        }
        task.resume()
    }
}

