//
//  Endpoints.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation

public enum StaticEndpoints {
    
    static let SERVER_URL = "http://api.ozinshe.com"
        
    public static let Login: String = {
        return SERVER_URL + "/auth/V1/signin"
    }()
    
    public static let SignUp: String = {
        return SERVER_URL + "/auth/V1/signup"
    }()
    
}

public let Endpoints = StaticEndpoints.self
