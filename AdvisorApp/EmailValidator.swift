//
//  EmailValidator.swift
//  AdvisorApp
//
//  Created by Damien on 30/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//


extension String {
    var isValidEmail : Bool {
        return !(self.isEmpty)
    }
}