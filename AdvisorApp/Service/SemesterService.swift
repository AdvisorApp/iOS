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
    
    static func add(
        studyPlanId: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (Semester -> ())? = nil
    ) {
        
        Service.request(.POST, path: "/api/studyPlans/\(studyPlanId)/semesters", parameters: [:], failure: { error in
            fail!(error)
        }) { (semester: Semester) in
            succeed!(semester)
        }
    }
    
    static func addUv(
        semesterId: Int,
        uvId: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (Semester -> ())? = nil
    ) {
        
        print("semesterId \(semesterId)")
        print("uvId \(uvId)")
        
        Service.request(.PUT, path: "/api/semesters/\(semesterId)/uv/\(uvId)", parameters: [:], failure: { error in
            fail!(error)
        }) { (semester: Semester) in
            succeed!(semester)
        }
    }
    
    static func delete(
        id: Int,
        failure fail: (RequestError -> ())? = nil,
        success succeed: (Void -> ())? = nil
    ) {
        
        Service.request(.DELETE, path: "/api/semesters/\(id)", failure: { error in
            fail!(error)
        }) { _ in
            succeed!()
        }
    }
}