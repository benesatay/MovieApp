//
//  RequestManager.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import UIKit

class RequestManager {
    class func get<T: Mappable>(_ endpoint: Service.Enpoints, _ obj: T.Type, _ params:[String:Any]? = nil, completion: @escaping (T?, Error?) -> Void) {
        let URL = endpoint.url
        let method = endpoint.method
        let encoding = endpoint.encoding
       
        var parameters = params
        parameters?.updateValue(Service.apiKey, forKey: "apiKey")
        
        AF.request(URL, method: method, parameters: parameters, encoding: encoding).responseObject { (response: DataResponse<T,AFError>) in
            let result = response.result
            switch result {
            case .success(let data):
                completion(data, nil)
            case .failure(let err):
                completion(nil,err)
            }
        }
    }
}


struct Service {
    static let serviceUrl       = "http://www.omdbapi.com/"
    static let apiKey: String = "2660e545"

    enum Enpoints {
        case series
        case content

        public var url: String {
            switch self {
            case .series, .content:
                return String(format: "%@", Service.serviceUrl)
            }
        }

        public var method: HTTPMethod {
            switch self {
            default:
                return .get
            }
        }

        public var encoding: ParameterEncoding {
            switch self {
            default:
                return URLEncoding.queryString
            }
        }

//        public var headers: HTTPHeaders {
//            switch self {
//            default:
//
//            }
//        }

//        private var relativeURL: String {
//            switch self {
//            case .series:
//
//            case .content:
//
//            }
//        }

//        private var concept: String {
//            switch self {
//            case .series:

//            case.content :
//
//            }
//        }
    }

//    enum Params: String {
//       
//
//    }


}
