import UIKit
import EVReflection

class Uv: EVObject {
    var id: Int = 0
    var remoteId: String = ""
    var name: String = ""
    var _description: String?
    var minSemester: Int = 0
    var isAvailableForCart: Bool = false
    var chs: Int = 0
    var location: Location?
    var uvType: UvType?
    var semesters: [Semester] = []
    var corequisitesUv: [Uv] = []
    var corequisitesUvOf: [Uv] = []
    var prerequisitesUv: [Uv] = []
    var teacherName: String = ""
    
    func isFinished() -> Bool {
        // TODO
        return chs > 2
    }
}