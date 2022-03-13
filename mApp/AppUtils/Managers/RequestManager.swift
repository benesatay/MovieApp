//
//  RequestManager.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 18.07.2021.
//

import Alamofire
import UIKit

class RequestManager {
    
    class func request(_ endpoint: Service.Enpoints, _ params:[String:Any]? = nil) async throws -> Data {
        let URL = endpoint.url
        let method = endpoint.method
        let encoding = endpoint.encoding
       
        var parameters = params
        parameters?.updateValue(Service.apiKey, forKey: "apiKey")
        
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(URL, method: method, parameters: parameters, encoding: encoding).validate().responseData { response in
                if let error = response.error {
                    continuation.resume(throwing: error)
                    return
                }

                if let data = response.data {
                    continuation.resume(returning: data)
                    return
                }
                fatalError("should not get here")
            }
        })
    }
    
    class func cancelRequest() async {
        await withTaskCancellationHandler {
            Alamofire.Session.default.cancelAllRequests()
        } operation: {
            await withCheckedContinuation { continuation in
                continuation.resume()
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
    }
}
