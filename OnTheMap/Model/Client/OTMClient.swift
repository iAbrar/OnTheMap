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
        static var accountKey = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        
        case login
        case studentsLocation
        case userInfo
        
        var stringValue: String {
            switch self {
                
            case .login: return Endpoints.base + "/session"
                
            case .studentsLocation: return Endpoints.base + "/StudentLocation"
                
            case .userInfo: return Endpoints.base + "/users/" + Auth.accountKey

                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    //login request
    class func login(email: String, password: String, completion: @escaping (Error?) -> Void){
        
        var request = URLRequest(url: Endpoints.login.url)
        
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

            if let json = try? JSONSerialization.jsonObject(with: newData!, options: []),
                let dictionary = json as? [String:Any],
                let sessionDictionary  = dictionary["session"] as? [String: Any],
                let accountDictionary  = dictionary["account"] as? [String: Any]  {
                
                Auth.accountKey = (accountDictionary["key"] as? String)!
                Auth.sessionId = (sessionDictionary["id"] as? String)!
                
            } else { //Err in parsing data
               print("error")
            }
           
            self.getUserInfo() { (error) in
                
                guard error == nil else {
                    print(error)
                    return
                }
                
                
            }
            completion(nil)
        }
        
        task.resume()
    }
    
    class func logout(completion: @escaping (Error?) -> Void){
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    completion(error)
                }
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            Auth.accountKey = ""
            Auth.sessionId = ""
            
            completion(nil)
        }
        task.resume()
    }
    
    class func getUserInfo(completion: @escaping (Error?) -> Void){
        let request = URLRequest(url: Endpoints.userInfo.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print("inside get info")
            print(String(data: newData!, encoding: .utf8)!)
            
            if let json = try? JSONSerialization.jsonObject(with: newData!, options: []),
                let dictionary = json as? [String:Any],
                let keyDictionary  = dictionary["key"] as? [String: Any],
                let firstNameDictionary  = dictionary["firstName"] as? [String: Any],
                let lastNameDictionary  = dictionary["lastName"] as? [String: Any]{

                UserInfoModel.user.key = (keyDictionary["key"] as? String)!
                UserInfoModel.user.firstName = (firstNameDictionary["firstName"] as? String)!
                UserInfoModel.user.lastName = (lastNameDictionary["lastName"] as? String)!

            } else { //Err in parsing data
                print("error")
            }
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

