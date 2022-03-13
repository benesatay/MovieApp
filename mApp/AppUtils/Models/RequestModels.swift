//
//  RequestModels.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import Foundation

//MARK: - BASE REQUEST
protocol BaseRequest: Codable {

}

extension BaseRequest {
    func convertToDictionary() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        return dict
    }
}

//MARK: - BASE DIGITAL CONTENT REQUEST
struct DigitalContentRequest: BaseRequest {
    var title: String?
    var year: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "t"
        case year = "y"
    }
}

//MARK: - SERIES REQUEST
struct SeriesRequest: BaseRequest {
    var title: String?
    var year: String?
    var series: String?
    
    enum CodingKeys: String, CodingKey {
        case series = "s"
    }
}

//MARK: - SELECTED DIGITAL CONTENT DETAIL REQUEST
struct ContentDetailRequest: BaseRequest {
    var title: String?
    var year: String?
    var id: String?
    var plot: String?
    enum CodingKeys: String, CodingKey {
        case id = "i"
        case plot = "plot"
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
