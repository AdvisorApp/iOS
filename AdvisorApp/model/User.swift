//
//  User.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit
import SwiftyJSON

struct User {
    var id: Double
    var firstName: String
    var lastName: String
    var email: String
    
    static func fromJSON(json: JSON) -> User {
        let id = json["id"].doubleValue
        let firstName = json["firstName"].stringValue
        let lastName = json["lastName"].stringValue
        let email = json["email"].stringValue
        
        return User(id: id, firstName: firstName, lastName: lastName, email: email)
    }
}

