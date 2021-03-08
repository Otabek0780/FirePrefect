import Foundation

struct Post: Hashable {
    var title: String?
    var title2: String?
    var phone: String?
    var imgUrl: String?
    
    init(title: String?, title2: String?, phone: String?) {
        self.title = title
        self.title2 = title2
        self.phone = phone
        
    }
    
    init(title: String?, title2: String?, phone: String?, imgUrl: String?) {
        self.title = title
        self.title2 = title2
        self.phone = phone
        self.imgUrl = imgUrl
    }
}
