//
//  Model.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//


import ObjectMapper

class BaseResponse: Mappable, Decodable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
  
    }
}

// MARK: - Movies Response

class MoviesResponse: BaseResponse {
    var search: [SearchResponse]?
    var totalResults, response: String?

    override func mapping(map: Map) {
        search <- map["Search"]
        totalResults <- map["totalResults"]
        response <- map["Response"]
    }
}

// MARK: - Movies Search Response
class SearchResponse: BaseResponse {
    var title, year, imdbID: String?
    var type: String?
    var poster: String?
    
    override func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        imdbID <- map["imdbID"]
        type <- map["series"]
        poster <- map["Poster"]
        year <- map["Year"]
    }
}

enum ProductionType {
    case movie
    case series
    var type: String {
        switch self {
        case .movie:
            return "movie"
        case .series:
            return "series"
        }
    }
}


// MARK: - Movie Response
class MovieResponse: BaseResponse {
    var title, year, rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var poster: String?
    var ratings: [Rating]?
    var metascore, imdbRating, imdbVotes, imdbID: String?
    var type: String?
    var dvd, boxOffice, production: String?
    var website, response: String?

    override func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        rated <- map["Rated"]
        released <- map["Released"]
        runtime <- map["Runtime"]
        genre <- map["Genre"]
        director <- map["Director"]
        writer <- map["Writer"]
        actors <- map["Actors"]
        plot <- map["Plot"]
        language <- map["Language"]
        country <- map["Country"]
        awards <- map["Awards"]
        poster <- map["Poster"]
        ratings <- map["Ratings"]
        metascore <- map["Metascore"]
        imdbRating <- map["imdbRating"]
        imdbVotes <- map["imdbVotes"]
        imdbID <- map["imdbID"]
        type <- map["Type"]
        dvd <- map["DVD"]
        boxOffice <- map["BoxOffice"]
        production <- map["Production"]
        website <- map["Website"]
        response <- map["Response"]
    }
}

// MARK: - Rating
class Rating: BaseResponse {
    var source, value: String?
    override func mapping(map: Map) {
        source <- map["source"]
        value <- map["value"]
    }
}

