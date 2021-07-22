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

    class func get<T: Mappable>(_ endpoint: String, _ obj: T.Type, _ params:[String:Any]? = nil, completion: @escaping (T?, Error?) -> Void) {
        AF.request(endpoint, method: .get, parameters: params, encoding: URLEncoding.queryString).responseObject { (response: DataResponse<T,AFError>) in
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
