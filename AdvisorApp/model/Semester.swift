//
//  Semester.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

struct Semester {
    var id: Double
    var number: Int
    var studyPlan: StudyPlan?
    var uvs: [Uv]
    
    init(id: Double, number: Int, uvs: [Uv]) {
        self.id = id;
        self.number = number
        self.uvs = uvs
    }
    
    func getSumCreditHours() -> Int {
        return uvs.reduce(0, combine: {$0 + $1.chs!})
    }
}