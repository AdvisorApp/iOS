//
//  Request.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 30/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation
import Alamofire

enum RequestError: ErrorType {
    case Unauthorized
    case Other(NSError)
    
    static func fromNSError(error: NSError) -> RequestError {
        let statusCode = error.userInfo["StatusCode"] as! Int
        
        switch statusCode {
        case 404:
            return RequestError.Unauthorized
        default:
            return RequestError.Other(error)
        }
    }
}

class Request {
    static let baseURLString = "http://localhost:8090" // "http://chardan.net:8090"
 
    static func url(method: Alamofire.Method, path: String, parameters: [String: AnyObject]?) -> NSMutableURLRequest {
        let URL = NSURL(string: UserRequest.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        // Adding authorization token
        if let token = Auth.getToken() {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "X-Authorization")
        }
        
        if parameters == nil {
            return mutableURLRequest
        }
        
        return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
    }
    
    static func url(method: Alamofire.Method, path: String) -> NSMutableURLRequest {
        return Request.url(method, path: path, parameters: nil)
    }
}