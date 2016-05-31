//
//  Semester.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit
import EVReflection

class Semester: EVObject {
    var id: Int? = 0
    var number: Int? = 0
    var studyPlan: StudyPlan?
    var uvs: [Uv]? = []
    
    func getSumCreditHours() -> Int {
        return uvs!.reduce(0, combine: {$0 + $1.chs!})
    }
}