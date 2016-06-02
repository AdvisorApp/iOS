import UIKit
import EVReflection

class StudyPlan: EVObject {
    var id: Int = 0
    var user: User?
    var name: String = ""
    var semesters: [Semester] = []
}