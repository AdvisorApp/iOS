//
//  Auth.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 29/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation

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
    
    static func clear() {
        userDefaults.removeObjectForKey("token")
    }
}