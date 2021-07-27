//
//  RequestModels.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import ObjectMapper

//MARK: - BASE REQUEST
class BaseRequest: NSObject, Mappable {
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
}

//MARK: - BASE DIGITAL CONTENT REQUEST
class DigitalContentRequest: BaseRequest {
    var title: String?
    var year: String?
    override func mapping(map: Map) {
//        title <- map["t"]
//        year <- map["y"]
    }
}

//MARK: - SERIES REQUEST
class SeriesRequest: DigitalContentRequest {
    var series: String?
    override func mapping(map: Map) {
        series <- map["s"]
    }
}

//MARK: - SELECTED DIGITAL CONTENT DETAIL REQUEST
class ContentDetailRequest: DigitalContentRequest {
    var id: String?
    var plot: String?
    override func mapping(map: Map) {
        id <- map["i"]
        plot <- map["plot"]
    }
}

enum PlotType {
    case full
    case short
    
    var description: String? {
        switch self {
        case .full:
            return "full"
        case .short:
            return nil
        }
    }
}
