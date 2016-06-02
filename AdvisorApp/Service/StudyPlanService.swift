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
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([StudyPlan] -> ())? = nil
    ) {

        // TODO : use the connected user id
        Service.requestArray(.GET, path: "/api/users/1/studyPlans", failure: { error in
            fail!(error)
        }) { (studyPlans: [StudyPlan]) in
            succeed!(studyPlans)
        }
    }
}