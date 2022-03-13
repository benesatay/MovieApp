//
//  ResponseModels.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//


// MARK: - BASE RESPONSE
protocol BaseResponse: Decodable {

}

// MARK: - SERIES RESPONSE
struct SeriesResponse: BaseResponse {
    var search: [SearchResponse]?
    var totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - SERIES SEARCH RESPONSE
struct SearchResponse: BaseResponse {
    let title, year, imdbID: String?
    let type: TypeEnum?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

// MARK: - CONTENT DETAIL RESPONSE
struct ContentDetailResponse: BaseResponse {
    var title, year, imdbID: String?
    var type: String?
    var poster: String?
       
    var rated, released: String?
    var runtime, genre, director, writer: String?
    var actors, plot, language, country: String?
    var awards: String?
    var ratings: [Rating]?
    var metascore, imdbRating, imdbVotes: String?
    var dvd, boxOffice, production: String?
    var website, response: String?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbVotes = "imdbVotes"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

// MARK: - CONTENT DETAIL RATINGS RESPONSE
struct Rating: BaseResponse {
    var source, value: String?
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case value = "value"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
