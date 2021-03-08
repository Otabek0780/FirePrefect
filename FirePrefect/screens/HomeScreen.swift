

import SwiftUI
import Firebase


struct HomeScreen: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var database = RealtimeStore()
    @State var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    func apiPost() {
        isLoading = true
        database.loadPosts {
            isLoading = false
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                List{
                    ForEach(database.items, id: \.self){ item in
                        PostCell(post: item)
                        
                    }
                }.listStyle(PlainListStyle())
                
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    HStack{
                                        NavigationLink(
                                            destination: Add_Screen(),
                                            label: {
                                                Image(systemName: "plus")
                                            })
                                            .foregroundColor(.purple)
            
                                        Button(action: {
                                            doSignOut()
                                        }, label: {
                                            Image(systemName: "trash")
                                        })
                                        .foregroundColor(.purple)
                                    }
            )
            .navigationBarTitle("Contacts", displayMode: .inline)
            
        }.onAppear{
            apiPost()
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
