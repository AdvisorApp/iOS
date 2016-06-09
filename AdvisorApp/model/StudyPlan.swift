//
//  Semester.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//

import UIKit
import EVReflection

class StudyPlan: EVObject {
    var id: Int = 0
    var user: User?
    var name: String = ""
    var semesters: [Semester] = []
}