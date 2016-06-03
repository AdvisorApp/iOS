//
//  UvService.swift
//  AdvisorApp
//
//  Created by Clément Garbay on 03/06/2016.
//

import Foundation

class UvService {
    
    static func get(
        studyPlanId: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: ([Uv] -> ())? = nil
    ) {
        
        Service.requestArray(.GET, path: "/api/studyPlans/\(studyPlanId)/remainingUvs", failure: { error in
            fail!(error)
        }) { (uvs: [Uv]) in
            succeed!(uvs)
        }
    }
}