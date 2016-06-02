//
//  Studyplan.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit
import EVReflection

class StudyPlan: EVObject {
    var id: Double?
    var user: User?
    var name: String?
    var semesters: [Semester]?
    var options: Option?
}