//
//  MovieRequest.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import Foundation
import ObjectMapper
class BaseRequest: NSObject, Mappable {
//    var apiKey: String?
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
//        apiKey <- map["apikey"]
    }
}

class MovieRequest: BaseRequest {
    var series: String?
    var title: String?
//    var type: RequestType?
    var year: String?
    var id: String?
    override func mapping(map: Map) {
//        super.mapping(map: map)
        series <- map["s"]
        title <- map["t"]
//        type <- map[type?.type ?? ""]
        year <- map["y"]
        id <- map["i"]
    }

}

enum RequestType {
    case title
    case series
    
    var type: String {
        switch self {
        case .title:
            return "t"
        case .series:
            return "s"
        }
    }
}
