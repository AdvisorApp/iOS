//
//  Semester.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//

import UIKit
import EVReflection

class UvUser: EVObject {
    var id: Int = 0
    var user: User?
    var uv: Uv?
    var userAverage: Double = 0.0
    var uvMark: Double = 0.0
    var uvComment: String = ""
    var teacherComment: String = ""
}