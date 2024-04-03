//
//  CoreService.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class CoreService {
    static let Worker = CoreService()
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
    ]
    
    
    func getBanners(completionHandler: @escaping (_ success: Bool,
                                                  _ errorMessage: String?,
                                                  [MovieBanner]) -> Void) {
        var bannersList: [MovieBanner] = []
        
        AF.request(Endpoints.GetBanners, method: .get, headers: headers).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("getBanners JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let movieBanner = MovieBanner(json: item)
                        bannersList.append(movieBanner)
                    }
                }
                
                completionHandler(true, nil, bannersList)
                return
            }
            
            completionHandler(false, self.decodeError(response), bannersList)
            return
        }
    }
    
    func getKeepWatchingMovies(completionHandler: @escaping (_ success: Bool,
                                                             _ errorMessage: String?,
                                                             [MovieWithDetails]) -> Void) {
        var keepWatchingMoviesList: [MovieWithDetails] = []
        
        AF.request(Endpoints.UserHistory, method: .get, headers: headers).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("getKeepWatchingMovies JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let historyMovie = MovieWithDetails(json: item)
                        keepWatchingMoviesList.append(historyMovie)
                    }
                }
                
                completionHandler(true, nil, keepWatchingMoviesList)
                return
            }
            
            completionHandler(false, self.decodeError(response), keepWatchingMoviesList)
            return
        }
    }
    
    func getGenres(completionHandler: @escaping (_ success: Bool, 
                                                 _ errorMessage: String?,
                                                 [Genre]) -> Void) {
        var genresList: [Genre] = []
        
        AF.request(Endpoints.GetGenres, method: .get, headers: headers).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("getGenres JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let genre = Genre(json: item)
                        genresList.append(genre)
                    }
                }
                
                completionHandler(true, nil, genresList)
                return
            }
            
            completionHandler(false, self.decodeError(response), genresList)
            return
        }
    }
    
    func getAgeCategories(completionHandler: @escaping (_ success: Bool,
                                                        _ errorMessage: String?,
                                                        [AgeCategory]) -> Void) {
        var ageCategoriesList: [AgeCategory] = []
        
        AF.request(Endpoints.GetAges, method: .get, headers: headers).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("getAgeCategories JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let ageCategory = AgeCategory(json: item)
                        ageCategoriesList.append(ageCategory)
                    }
                }
                
                completionHandler(true, nil, ageCategoriesList)
                return
            }
            
            completionHandler(false, self.decodeError(response), ageCategoriesList)
            return
        }
    }
    
    func getMoviesCells(completionHandler: @escaping (_ success: Bool,
                                                      _ errorMessage: String?,
                                                      [MoviesSection]) -> Void) {
        var moviesCellsList: [MoviesSection] = []
        
        AF.request(Endpoints.GetMoviesCells, method: .get, headers: headers).responseData { response in
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("getMoviesCells JSON: \(json)")
                
                if let array = json.array {
                    for item in array {
                        let moviesCell = MoviesSection(json: item)
                        moviesCellsList.append(moviesCell)
                    }
                }
                
                completionHandler(true, nil, moviesCellsList)
                return
            }
            
            completionHandler(false, self.decodeError(response), moviesCellsList)
            return
        }
    }
    
    
}

extension CoreService {
    
    fileprivate func decodeError(_ response: AFDataResponse<Data>) -> String {
        var resultString = ""
        if let data = response.data {
            resultString = String(data: data, encoding: .utf8)!
        }
        
        var errorString = "CONNECTION_ERROR"
        if let sCode = response.response?.statusCode {
            errorString = errorString + " \(sCode)"
        }
        return errorString + " \(resultString)"
    }
    
    
}
