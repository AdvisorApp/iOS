//
//  Router.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 29/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation

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


