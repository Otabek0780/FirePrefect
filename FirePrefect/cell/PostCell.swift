
import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    
    var post: Post
    
    var body: some View {
        
        HStack{
            
            if post.imgUrl != nil {
                WebImage(url: URL(string: post.imgUrl!))
                    .resizable()
                    .frame(height: 100).frame(width: 100)
                    .scaledToFit()
                    .cornerRadius(25)
            }else{
                Image("swift")
                    .resizable()
                    .frame(height: 100).frame(width: 100)
                    .scaledToFit()
                    .cornerRadius(25)
            }
            
            VStack(alignment: .leading){
                HStack {
                    Text(post.title!.uppercased())
                        .fontWeight(.bold)
                    Text(post.title2!.uppercased())
                        .fontWeight(.bold)
                }
                Text(post.phone!).padding(.top,5)

            }.padding()
        }
        
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Post(title: "surname", title2: "name", phone: "phone"))
    }
}
