import UIKit
import SwiftyJSON
import EVReflection

class User: EVObject {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var remoteId: String = ""
    var password: String = ""
    var birthday: NSDate = NSDate()
}

