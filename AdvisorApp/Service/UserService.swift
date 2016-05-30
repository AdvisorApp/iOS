//
//  UserService.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 28/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum UserRequest: URLRequestConvertible {
    static let baseURLString = "http://localhost:8090" // "http://chardan.net:8090"
    
    case Create([String: AnyObject])
    case Get()
    case Login([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Create:
            return .POST
        case .Get:
            return .GET
        case .Login:
            return .POST
        }
    }
    
    var path: String {
        switch self {
        case .Create:
            return "/api/users"
        case .Get:
            return "/api/users/me"
        case .Login:
            return "/api/auths/token"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: UserRequest.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Auth.getToken() {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "X-Authorization")
        }
        
        switch self {
        case .Create(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .Login(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}

class UserService {
    
    static func signin(
        email: String,
        password: String,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (Void -> ())? = nil
    ) {
        
        let parameters: [String: AnyObject] = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire
            .request(Request.url(.POST, path: "/api/auths/token", parameters: parameters))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success(let body):
                    let json = JSON(body)
                    Auth.setToken(json["token"].stringValue)
                    succeed!()
                case .Failure(let error):
                    fail!(RequestError.fromNSError(error))
                }
            }
    }
}