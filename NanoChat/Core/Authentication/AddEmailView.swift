//
//  AddEmailView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import SwiftUI

struct AddEmailView: View {
        
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Add Email")
                    .padding(.bottom, 50)
                    .font(.title)
                    .bold()
                    .padding(.top, 50)
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                
                NavigationLink(destination: CreateUserView().navigationBarBackButtonHidden()) {
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}


