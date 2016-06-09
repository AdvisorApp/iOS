//
//  Auth.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 29/05/2016.
//

import Foundation
import JWTDecode

class Auth {
    
    private static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    private init() {} // Singleton
    
    static func isAuthenticated() -> Bool {
        // TODO : check token validity
        return Auth.getToken() != nil
    }
    
    static func setToken(token: String) {
        userDefaults.setValue(token, forKeyPath: "token")
    }
    
    static func getToken() -> String? {
        return userDefaults.valueForKey("token") as? String
    }
    
    // TODO : review unwrapping
    static func getConnectedUserId() -> Int? {
        if let token = userDefaults.valueForKey("token") as? String {
            do {
                let jwt = try decode(token)
                if let subject = Int(jwt.subject!) {
                    return subject
                }
            } catch _ {}
        }
        return nil
    }
    
    static func clear() {
        userDefaults.removeObjectForKey("token")
    }
}