//
//  StudyPlanService.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 30/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation

class StudyPlanService {
    
    static func get(
        userId: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([StudyPlan] -> ())? = nil
    ) {

        Service.requestArray(.GET, path: "/api/users/\(userId)/studyPlans", failure: { error in
            fail!(error)
        }) { (studyPlans: [StudyPlan]) in
            succeed!(studyPlans)
        }
    }
}