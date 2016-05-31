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
        
        Service.request(.POST, path: "/api/auths/token", parameters: parameters, failure: { error in
            fail!(error)
        }) { (token: Token) in
            Auth.setToken(token.token!)
            succeed!()
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
        
        
        Service.request(.POST, path: "/api/auths/signup", parameters: parameters, failure: { error in
            print("Fail on sign up \(error)")
            fail!(error)
        }) { _ in
            print("SignUp success")
            succeed!()
        }
        
    }
}