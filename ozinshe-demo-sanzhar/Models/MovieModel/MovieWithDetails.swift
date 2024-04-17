//
//  Movie.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

final class MovieWithDetails {
    var id: Int = 0
    
    var isFavorite: Bool = false
    
    var movieType: String = ""
    var name: String = ""
    var keyWords: String = ""
    var shortInfo: String = ""
    var description: String = ""
    
    var year: Int = 0
    var trend: Bool = false
    var timing: Int = 0
    
    var director: String = ""
    var producer: String = ""
    
    var poster_link: String = ""
    var video_link: String = ""
    
    var watchCount: Int = 0
    var seasonCount: Int = 0
    var seriesCount: Int = 0
    
    var createdDate: String = ""
    var lastModifiedDate: String = ""
    
    var screenshots: [Screenshot] = []
    var categoryAges: [ContentCategory] = []
    var genres: [ContentCategory] = []
    
    var categories: [ContentCategory] = []
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["id"].int                    { self.id = temp }
        
        if let temp = json["favorite"].bool             { self.isFavorite = temp }
        
        if let temp = json["movieType"].string          { self.movieType = temp }
        if let temp = json["name"].string               { self.name = temp }
        if let temp = json["keyWords"].string           { self.keyWords = temp }
        if let temp = json["description"].string        { self.description = temp }
        if let temp = json["year"].int                  { self.year = temp }
        if let temp = json["trend"].bool                { self.trend = temp }
        if let temp = json["timing"].int                { self.timing = temp }
        if let temp = json["director"].string           { self.director = temp }
        if let temp = json["producer"].string           { self.producer = temp }
        
        if let temp = json["watchCount"].int            { self.watchCount = temp }
        if let temp = json["seasonCount"].int           { self.seasonCount = temp }
        if let temp = json["seriesCount"].int           { self.seriesCount = temp }
        if let temp = json["createdDate"].string        { self.createdDate = temp }
        if let temp = json["lastModifiedDate"].string   { self.lastModifiedDate = temp }
        
        if json["poster"].exists() {
            if let temp = json["poster"]["link"].string {
                self.poster_link = temp
            }
        }
        
        if json["video"].exists() {
            if let temp = json["video"]["link"].string {
                self.video_link = temp
            }
        }
        
        if let array = json["screenshots"].array {
            for item in array {
                if let temp = Screenshot(json: item) {
                    self.screenshots.append(temp)
                }
            }
        }
        
        if let array = json["categoryAges"].array {
            for item in array {
                if let temp = ContentCategory(json: item) {
                    self.categoryAges.append(temp)
                }
            }
        }
        
        if let array = json["genres"].array {
            for item in array {
                if let temp = ContentCategory(json: item) {
                    self.genres.append(temp)
                }
            }
        }
        
        if let array = json["categories"].array {
            for item in array {
                if let temp = ContentCategory(json: item) {
                    self.categories.append(temp)
                }
            }
        }
        
        self.shortInfo = "\(year)"
        self.genres.forEach { self.shortInfo = self.shortInfo + " • " + $0.name }
    }
    
    func findSimilarTVSeries(moviesSectionsList: [MoviesSection]) -> [MovieWithDetails] {
        let movie = self
        var similarTVSeries: [MovieWithDetails] = []
        movie.categories.forEach { category in
            moviesSectionsList.forEach { cell in
                if cell.categoryName == category.name {
                    cell.movies.forEach { similarMovie in
                        if similarMovie.name != movie.name {
                            similarTVSeries.append(similarMovie)
                        }
                    }
                }
            }
        }
        
        let uniqueSimilarTVSeries = MovieWithDetails.removeDuplicateElements(movies: similarTVSeries)
        return uniqueSimilarTVSeries
    }
    
    static func removeDuplicateElements(movies: [MovieWithDetails]) -> [MovieWithDetails] {
        var uniqueMovies = [MovieWithDetails]()
        for movie in movies {
            if !uniqueMovies.contains(where: {$0.id == movie.id }) {
                uniqueMovies.append(movie)
            }
        }
        return uniqueMovies
    }
    
    
    
}

