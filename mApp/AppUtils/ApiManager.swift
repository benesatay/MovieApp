//
//  ApiManager.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import Foundation

class ApiManager {
    
    static let baseURL: String = "http://www.omdbapi.com/"
    
    static let apiKey: String = "2660e545"
    class func getMovies(_ req: MovieRequest, onSuccess: @escaping (MoviesResponse) -> Void, onError: @escaping (String) -> Void) {
        var endpoint: String = ""
        if req.year != nil {
            endpoint = String(format: "%@?s=%@&y=%@&apikey=%@", baseURL, (req.series ?? ""), (req.year ?? ""), apiKey)
        } else {
            endpoint = String(format: "%@?s=%@&apikey=%@", baseURL, (req.series ?? ""), apiKey)
        }
        cLog(endpoint)
        RequestManager.get(endpoint, MoviesResponse.self) { (response, error) in
            guard error == nil else { return onError(error!.localizedDescription) }
            if response != nil {
                onSuccess(response!)
            }
        }
    }
    
    class func getSelectedMovie(_ req: MovieRequest, onSuccess: @escaping (MovieResponse) -> Void, onError: @escaping (String) -> Void) {
        let plotType = "full"
        let endpoint = String(format: "%@?i=%@&plot=%@&apikey=%@", baseURL, (req.id ?? ""), plotType, apiKey)
        cLog(endpoint)
        RequestManager.get(endpoint, MovieResponse.self) { (response, error) in
            guard error == nil else { return onError(error!.localizedDescription) }
            if response != nil {
                onSuccess(response!)
            }
        }
    }
}
