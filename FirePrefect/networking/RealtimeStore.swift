
import Foundation
import FirebaseDatabase


class RealtimeStore: ObservableObject {
    var ref: DatabaseReference = Database.database().reference(withPath: "posts")
    @Published var items: [Post] = []
    
    func storePost(post: Post, completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        let toBePosted = ["surname": post.title!, "name": post.title2!, "phone": post.phone!, "imageUrl": post.imgUrl!]
        
        ref.childByAutoId().setValue(toBePosted){ (error, ref) -> Void in
            if error != nil{
                success =  false
            }
        }
        completion(success)
    }
    
    func loadPosts(completion: @escaping () -> ()) {
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let title = value!["surname"] as? String
                    let title2 = value!["name"] as? String
                    let phone = value! ["phone"] as? String
                    let imgUrl = value!["imageUrl"] as? String
                    self.items.append(Post(title: title,title2: title2, phone: phone, imgUrl: imgUrl))
                }
            }
            completion()
        }
    }
}
