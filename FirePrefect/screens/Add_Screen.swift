//
//  Add_Screen.swift
//  FirePrefect
//
//  Created by kim jong moon on 07/03/2021.
//

import SwiftUI

struct Add_Screen: View {
    
    @ObservedObject var database = RealtimeStore()
    @ObservedObject var storage = StorageStore()
    @Environment(\.presentationMode) var presentation
    @State var isLoading = false
    @State var title: String = ""
    @State var title2: String = ""
    @State var phone: String = ""
    
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    @State var defImage = UIImage(imageLiteralResourceName: "swift")
    
    func addNewPost(urlString: String){
        let post = Post(title: title, title2: title2, phone: phone, imgUrl: urlString)
        database.storePost(post: post, completion: { success in
            isLoading = false
            if success {
                self.presentation.wrappedValue.dismiss()
            }
        })
    }
    func uploadImage() {
        isLoading = true
        storage.uploadImage(pickedImage!, completion: { downloadURL in
            let urlString = downloadURL!.absoluteString
            print(urlString)
            addNewPost(urlString: urlString)
        })
    }

    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack{

                
                
                Button(action: {
                    self.showImagePicker.toggle()
                }, label: {
                    Image(uiImage: pickedImage ?? defImage)
                        .resizable()
                        .frame(height: 200).frame(width: 200)
                        .scaledToFit()
                        .cornerRadius(25)
                        .padding(.bottom)
                })
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                }, content: {
                    ImagePicker(image: self.$pickedImage, isShown: self.$showImagePicker)
                })
                
                TextField("Firstname", text: $title)
                    .frame(height: 50).padding(.leading, 10)
                    .background(Color.white).cornerRadius(25)
                TextField("Lastname", text: $title2)
                    .frame(height: 50).padding(.leading, 10)
                    .background(Color.white).cornerRadius(25)
                TextField("Phone", text: $phone)
                    .frame(height: 50).padding(.leading, 10)
                    .background(Color.white).cornerRadius(25)
                
                Button(action: {
                    
                    uploadImage()
                }, label: {
                    Spacer()
                    Text("Add").foregroundColor(.white)
                    Spacer()
                })
                .frame(height: 45)
                .background(Color.purple)
                .cornerRadius(25)
                Spacer()
            }.padding()
            if isLoading {
                ProgressView()
            }
        }
    }
}

struct Add_Screen_Previews: PreviewProvider {
    static var previews: some View {
        Add_Screen()
    }
}
