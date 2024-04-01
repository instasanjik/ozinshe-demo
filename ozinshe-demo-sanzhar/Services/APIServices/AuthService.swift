//
//  AuthService.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let Worker = AuthService()
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    func login(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        
        let parameters = ["email": email,
                          "password": password]
        
        AF.request(Endpoints.Login,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
//                print("JSON: \(json)")
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        }
    }
    
    func signUp(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        
        let parameters = ["email": email,
                          "password": password]
        
        AF.request(Endpoints.SignUp,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                } else {
                    completionHandler(false)
                }
            } else {
                completionHandler(false)
            }
        }
    }
    
    
}
