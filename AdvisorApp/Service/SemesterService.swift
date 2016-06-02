//
//  SemesterService.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 02/06/2016.
//

import Foundation

class SemesterService {
    
    static func get(
        studyPlanId: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([Semester] -> ())? = nil
    ) {

        Service.requestArray(.GET, path: "/api/studyPlans/\(studyPlanId)/semesters", failure: { error in
            fail!(error)
        }) { (semesters: [Semester]) in
            succeed!(semesters)
        }
    }
}