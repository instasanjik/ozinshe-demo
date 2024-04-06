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
    
    
    public static let GetBanners: String = {
        return SERVER_URL + "/core/V1/movies_main"
    }()
    
    public static let GetGenres: String = {
        return SERVER_URL + "/core/V1/genres"
    }()
    
    public static let UserHistory: String = {
        return SERVER_URL + "/core/V1/history/userHistory"
    }()
    
    public static let GetAges: String = {
        return SERVER_URL + "/core/V1/category-ages"
    }()
    
    public static let GetMoviesCells: String = {
        return SERVER_URL + "/core/V1/movies/main"
    }()
    
    public static let GetSeasons: String = {
        return SERVER_URL + "/core/V1/seasons/"
    }()
    
    public static let GetCategories: String = {
        return SERVER_URL + "/core/V1/categories"
    }()
    
    public static let GetMovieList: String = {
        return SERVER_URL + "/core/V1/movies/page"
    }()
    
}

public let Endpoints = StaticEndpoints.self
