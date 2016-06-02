//
//  UserService.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 28/05/2016.
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
            Auth.setToken(token.token)
            succeed!()
        }
    }
}