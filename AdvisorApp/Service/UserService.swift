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
    
    static func signup(
        user: UserSignUp,
        failure fail: (RequestError -> ())? = nil,
                success succeed: (Void -> ())? = nil
        ) {
        
        let parameters: [String: AnyObject] = [
            "firstName" : user.firstName,
            "lastName"  : user.lastName,
            "email" : user.email,
            "password": user.password,
            "remoteId": user.remoteId,
        ]
        
        print("SignUp(\(parameters)")
        
        Alamofire
            .request(Request.url(.POST, path: "/api/auths/signup", parameters: parameters))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success(_):
                    print("SignUp success")
                    succeed!()
                case .Failure(let error):
                    print("Fail on sign up \(error)")
                    fail!(RequestError.fromNSError(error))
                }
        }
    }
}