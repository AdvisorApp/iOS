//
//  UvService.swift
//  AdvisorApp
//
//  Created by Damien on 05/06/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation

class UvService {
    
    static func addCommentOrMark(
        userId: Int,
        uvId: Int,
        comment: String?,
        mark: Double?,
        failure fail: (RequestError -> ())? = nil,
                success succeed: (UvUser -> ())? = nil
        ) {
        
        let url = "/api/users/\(userId)/uvUsers/\(uvId)"
        
        Service.request(.GET, path: url, failure: { error in
            fail!(error)
        }) { (uvUser: UvUser) in
            if let com = comment {
                uvUser.uvComment = com
            }
            if let unwrapedMark = mark {
                uvUser.uvMark = unwrapedMark
            }
            
            Service.request(.PUT, path: url, parameters: (uvUser.toDictionary() as! [String : AnyObject]), failure: { error in
                fail!(error)
            }) { _ in
                succeed!(uvUser)
            }
            
        }
    }
    
    static func getUvUsersFromUvId(
        uvId: Int,
        failure fail: (RequestError -> ())? = nil,
                success succeed: ([UvUser] -> ())? = nil
        ) {
        Service.requestArray(.GET, path: "/api/uvs/\(uvId)/uvUsers", failure: { error in
            fail!(error)
        }) { (uvUser: [UvUser]) in
            succeed!(uvUser)
        }
    }
}