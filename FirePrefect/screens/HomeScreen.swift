//
//  HomeScreen.swift
//  FirePrefect
//
//  Created by kim jong moon on 07/03/2021.
//

import SwiftUI

struct HomeScreen: View {
    
    @EnvironmentObject var session: SessionStore
    @State var isLoading = false
    
    func doSignOut() {
        isLoading = true
        if SessionStore().signOut() {
            isLoading = false
            session.listen()
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                if session.session != nil {
                    Text(session.session!.email!)
                }
                if isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    HStack{
                                        Image(systemName: "applelogo")
                                        Button(action: {
                                            doSignOut()
                                        }, label: {
                                            Image(systemName: "trash")
                                        })
                                    }
            )
            .navigationBarTitle("Posts", displayMode: .inline)
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
