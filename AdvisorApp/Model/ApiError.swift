//
//  ApiError.swift
//  AdvisorApp
//
//  Created by Clément Garbay on 10/06/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation
import EVReflection

class ApiError: EVObject {
    var message: String = ""
    var detail: String = ""
}