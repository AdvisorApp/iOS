//
//  Uv.swift
//  AdvisorApp
//
//  Created by Clément GARBAY on 26/05/2016.
//  Copyright © 2016 Clément GARBAY. All rights reserved.
//

import Foundation

class Uv {
    var id: Double?
    var remoteId: String?
    var name: String?
    var description: String?
    var minSemester: Int?
    var isAvailableForCart: Bool?
    var chs: Double?
    var location: Location?
    var uvType: UvType?
    var semesters: [Semester]?
    var corequisitesUv: [Uv]?
    var corequisitesUvOf: [Uv]?
    var prerequisitesUv: [Uv]?
}