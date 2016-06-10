//
//  Request.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 30/05/2016.
//

import Foundation
import Alamofire
import AlamofireJsonToObjects
import EVReflection

enum RequestError: ErrorType {
    case Unauthorized
    case NotAcceptable(ApiError)
    case Other(NSError)
    
    static func fromNSError(error: NSError, apiError: ApiError) -> RequestError {
        return error.userInfo["StatusCode"]
            .map({(e: AnyObject) -> Int in e as! Int})
            .map({ e in
                switch e {
                case 404:
                    return RequestError.Unauthorized
                case 406:
                    return RequestError.NotAcceptable(apiError)
                default:
                    return RequestError.Other(error)
                }
            }) ?? RequestError.Other(error)
    }
    
    static func fromNSError(error: NSError) -> RequestError {
        return RequestError.fromNSError(error, apiError: ApiError())
    }
}

class Service {
    static let baseURLString = "https://9c418cfc.ngrok.io" // "http://localhost:8090" // "http://chardan.net:8090"
    
    static func getMutableURLRequest(method: Alamofire.Method, path: String, parameters: [String: AnyObject]?) -> NSMutableURLRequest {
        let URL = NSURL(string: Service.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        // Adding authorization token
        if let token = Auth.getToken() {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "X-Authorization")
        }
        
        return parameters == nil ? mutableURLRequest : Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
    }
    
    static func request<T: EVObject>(
        method: Alamofire.Method,
        path: String,
        parameters: [String: AnyObject]?,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (T -> ())? = nil
    ) {
        var apiError: ApiError = ApiError()
        
        Alamofire
            .request(Service.getMutableURLRequest(method, path: path, parameters: parameters))
            .validate()
            .response { request, response, data, error in
                // TODO : Review this!
                let json = String(data: data!, encoding: NSUTF8StringEncoding)
                apiError = ApiError(json: json)
            }
            .responseObject { (response: Result<T, NSError>) in
                switch response {
                case .Success(let object):
                    succeed!(object)
                case .Failure(let error):
                    fail!(RequestError.fromNSError(error, apiError: apiError))
                }
            }
    }
    
    static func request<T: EVObject>(
        method: Alamofire.Method,
        path: String,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (T -> ())? = nil
    ) {
        
        Service.request(method, path: path, parameters: nil, failure: { error in
            fail!(error)
        }) { (object: T) in
            succeed!(object)
        }
    }
    
    static func requestArray<T: EVObject>(
        method: Alamofire.Method,
        path: String,
        parameters: [String: AnyObject]?,
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([T] -> ())? = nil
    ) {
        
        Alamofire
            .request(Service.getMutableURLRequest(method, path: path, parameters: parameters))
            .validate()
            .responseArray { (response: Result<[T], NSError>) in
                switch response {
                case .Success(let objects):
                    succeed!(objects)
                case .Failure(let error):
                    fail!(RequestError.fromNSError(error))
                }
        }
    }
    
    static func requestArray<T: EVObject>(
        method: Alamofire.Method,
        path: String,
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([T] -> ())? = nil
    ) {
        
        Service.requestArray(method, path: path, parameters: nil, failure: { error in
            fail!(error)
        }) { (objects: [T]) in
            succeed!(objects)
        }
    }
}