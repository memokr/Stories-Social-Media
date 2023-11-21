//
//  CreateUserView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import SwiftUI

struct CreateUserView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        NavigationStack{
            VStack {
                
                Text("Create Username").padding(.bottom,50).font(.title).bold().padding(.top,50)
                VStack {
                    TextField("Username", text: $viewModel.username)
                        .autocapitalization (.none)
                        .font (. subheadline)
                        .padding (12)
                        .background (Color (.systemGray6))
                        .cornerRadius (10)
                        .padding (.horizontal, 24)
                    
                }
                
                NavigationLink(destination: CreatePasswordView().navigationBarBackButtonHidden()) {
                    Text("Continue")
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(colorScheme == .light ? .black : .white))
                        .cornerRadius(8)
                        .padding(.vertical)
                        .padding()
                }
                
                Spacer()
                
            }.toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Image (systemName: "chevron.left")
                        .imageScale (.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

