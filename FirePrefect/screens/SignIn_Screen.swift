//
//  SignIn_Screen.swift
//  FirePrefect
//
//  Created by kim jong moon on 07/03/2021.
//

import SwiftUI

struct SignIn_Screen: View {
    
    @EnvironmentObject var session: SessionStore
    @State var email = "lola@gmail.com"
    @State var password = "qwerty123"
    @State var isLoading = false
    
    
    func doSign_In() {
        isLoading = true
        SessionStore().signIn(email: email, password: password, handler: {(res, err) in
            isLoading = false
            if err != nil {
                print("Check email or password please !")
                return
            }
            print("Successfully Signed In !")
            session.listen()
        })
    }
    
    var body: some View {
        
            NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 10) {
                    
                    Spacer()
                    
                    Text("Fire\(Image(systemName: "applelogo"))Quick")
                        .bold()
                        .padding(.top)
                        .foregroundColor(.white)
                        .font(Font.custom("Pacifico-Regular", size: 30))
                    
                    profileImageView(img_View: "swift").padding(.bottom, 30)
                    
                    ZStack {
                        Text("background")
                            .frame(height: 51)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(25)
                            .padding(.trailing,12)
                            .padding(.leading,12)
                        TextField("User ID", text: $email)
                            .frame(height: 45)
                            .padding(.leading, 15)
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.trailing)
                            .padding(.leading)
                    }
                    
                    ZStack {
                        Text("background")
                            .frame(height: 51)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(25)
                            .padding(.trailing,12)
                            .padding(.leading,12)
                        SecureField("User PW", text: $password)
                            .frame(height: 45)
                            .padding(.leading, 15)
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.trailing)
                            .padding(.leading)
                    }
                        
                    ZStack {
                        Text("background")
                            .frame(height: 51)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(25)
                            .padding(.trailing,12)
                            .padding(.leading,12)
                        Button(action: {
                            doSign_In()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Pacifico-Regular", size: 20))
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .frame(height: 45)
                            .background(Color.purple)
                            .cornerRadius(25)
                            .padding(.trailing)
                            .padding(.leading)
                            
                    })
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account ?").foregroundColor(.white)
                        NavigationLink (
                            destination: SignUp_Screen(),
                            label: {
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.system(size: 19))
                            })
                    
                                            
                    }
                    
                    
                }
                if isLoading {
                    ProgressView()
                }
                
            }
        }
        
    }
}

struct SignIn_Screen_Previews: PreviewProvider {
    static var previews: some View {
        SignIn_Screen()
    }
}

struct profileImageView: View {
    
    let img_View: String
    
    var body: some View {
        ZStack {
            Image(img_View)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .clipShape(Circle())
                .overlay(
                    
                    ZStack {
//                        Text("SwiftUI")
//                            .foregroundColor(.white)
//                            .opacity(0.8)
//                            .font(.system(size: 25))
//                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 70))
                        
                        Circle().stroke(Color.white, lineWidth: 5)
                        
                    }
                )
            
        }
    }
}
