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


struct UserSignUp {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var remoteId: String
    
    func isEnoughComplete() -> Bool {
        return (self.email.isValidEmail) && (password.characters.count >= 8)
    }
}

