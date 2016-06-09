//
//  StudyPlanService.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 30/05/2016.
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
    
    static func add(
        userId: Int,
        name: String,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (StudyPlan -> ())? = nil
    ) {
        
        let parameters: [String: AnyObject] = [
            "name" : name
        ]
        
        Service.request(.POST, path: "/api/users/\(userId)/studyPlans", parameters: parameters, failure: { error in
            fail!(error)
        }) { (studyPlan: StudyPlan) in
            succeed!(studyPlan)
        }
    }
    
    static func delete(
        id: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (Void -> ())? = nil
    ) {
        
        Service.request(.DELETE, path: "/api/studyPlans/\(id)", failure: { error in
            fail!(error)
        }) { _ in
            succeed!()
        }
    }
}