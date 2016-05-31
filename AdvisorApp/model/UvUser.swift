//
//  UvUser.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit
import EVReflection

class UvUser: EVObject {
    var id: Int?
    var user: User?
    var uv: Uv?
    var userAverage: Double?
    var uvMark: Double?
    var uvComment: Double?
}