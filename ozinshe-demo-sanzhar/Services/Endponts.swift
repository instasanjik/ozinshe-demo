//
//  Endpoints.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation

/// Defines the base URL for server requests.
public enum ServerURL {
    static let baseURL = "http://api.ozinshe.com"
}

/// Defines endpoints for various API requests.
public enum Endpoints {
    // Authentication Endpoints
    public static let login = ServerURL.baseURL + "/auth/V1/signin"
    public static let signUp = ServerURL.baseURL + "/auth/V1/signup"
    
    // Core Endpoints
    public static let getBanners = ServerURL.baseURL + "/core/V1/movies_main"
    public static let getGenres = ServerURL.baseURL + "/core/V1/genres"
    public static let userHistory = ServerURL.baseURL + "/core/V1/history/userHistory"
    public static let getAges = ServerURL.baseURL + "/core/V1/category-ages"
    public static let getMoviesCells = ServerURL.baseURL + "/core/V1/movies/main"
    public static let getSeasons = ServerURL.baseURL + "/core/V1/seasons/"
    public static let getCategories = ServerURL.baseURL + "/core/V1/categories"
    public static let getMovieList = ServerURL.baseURL + "/core/V1/movies/page"
    public static let getFavorites = ServerURL.baseURL + "/core/V1/favorite/"
    public static let searchByMovieName = ServerURL.baseURL + "/core/V1/movies/search"
    public static let setMovieFavorite = ServerURL.baseURL + "/core/V1/favorite/"
    public static let getProfile = ServerURL.baseURL + "/core/V1/user/profile"
}
