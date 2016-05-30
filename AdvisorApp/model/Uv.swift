//
//  Uv.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import UIKit

struct Uv {
    var id: Double?
    var remoteId: String?
    var name: String
    var description: String
    var minSemester: Int?
    var isAvailableForCart: Bool?
    var chs: Int?
    var location: Location?
    var uvType: UvType?
    var semesters: [Semester]?
    var corequisitesUv: [Uv]?
    var corequisitesUvOf: [Uv]?
    var prerequisitesUv: [Uv]?
    
    init(name: String, description: String, chs: Int) {
        self.name = name
        self.description = description
        self.chs = chs
    }
    
    func isFinished() -> Bool {
        // TODO
        return chs > 2
    }
}