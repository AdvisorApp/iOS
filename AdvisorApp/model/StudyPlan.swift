import UIKit
import EVReflection

class StudyPlan: EVObject {
    var id: Int = 0
    var user: User?
    var name: String = ""
    
    func getSemesters(
        failure fail: (RequestError -> ())? = nil,
        success succeed: (T -> ())? = nil
    ) {
        SemesterService.get(id, failure: { error in
            fail!(error)
        }, success: { semesters in
            succeed!(semesters)
        })
    }
}