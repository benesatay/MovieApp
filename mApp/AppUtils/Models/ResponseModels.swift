//
//  ResponseModels.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import ObjectMapper

// MARK: - BASE RESPONSE
class BaseResponse: Mappable, Decodable {
    required init?(map: Map) {  }
    func mapping(map: Map) {
    }
}

// MARK: - BASE CONTENT RESPONSE
class BaseContentResponse: BaseResponse {
    var title, year, imdbID: String?
    var type: String?
    var poster: String?
       
    override func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        imdbID <- map["imdbID"]
        type <- map["Type"]
        poster <- map["Poster"]
        year <- map["Year"]
    }
}

// MARK: - SERIES RESPONSE
class SeriesResponse: BaseResponse {
    var search: [SearchResponse] = []
    var totalResults, response: String?
    override func mapping(map: Map) {
        search <- map["Search"]
        totalResults <- map["totalResults"]
        response <- map["Response"]
    }
}

// MARK: - SERIES SEARCH RESPONSE
class SearchResponse: BaseContentResponse {
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
}

// MARK: - CONTENT DETAIL RESPONSE
class ContentDetailResponse: BaseContentResponse {
    var rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var ratings: [Rating] = []
    var metascore, imdbRating, imdbVotes: String?
    var dvd, boxOffice, production: String?
    var website, response: String?
    override func mapping(map: Map) {
        super.mapping(map: map)
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
        ratings <- map["Ratings"]
        metascore <- map["Metascore"]
        imdbRating <- map["imdbRating"]
        imdbVotes <- map["imdbVotes"]
        dvd <- map["DVD"]
        boxOffice <- map["BoxOffice"]
        production <- map["Production"]
        website <- map["Website"]
        response <- map["Response"]
    }
}

// MARK: - CONTENT DETAIL RATINGS RESPONSE
class Rating: BaseResponse {
    var source, value: String?
    override func mapping(map: Map) {
        source <- map["source"]
        value <- map["value"]
    }
}

