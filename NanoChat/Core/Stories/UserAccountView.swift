//
//  UserAccountView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 17/11/23.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct UserAccountView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: EditUserModel

    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditUserModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            VStack {

                VStack(spacing:-25){
            
                    if let image = viewModel.profileImage {
                            
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                    } else {
                        
                        ProfileImageView(user: viewModel.user)
                        
                    }
                        
                    PhotosPicker(selection: $viewModel.selectedImage){
                        Image(systemName: "pencil")
                            .frame(width: 100,height: 100)
                            .foregroundColor(.black)
                    }
                   
                    Text(viewModel.user.username)
                        .font(.title)
                        .padding()
                        .bold()
                }.padding(.top,80)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .padding()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        Task {
                            try await viewModel.updateUserData()
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .padding()
                    }
                }
            }
        }
    }
}



