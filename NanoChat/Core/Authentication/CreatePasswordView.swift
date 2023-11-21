//
//  CreatePasswordView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import SwiftUI

import SwiftUI

struct CreatePasswordView: View {
    
    @Environment (\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    @State private var showAlert: Bool = false
    @State private var shouldNavigate: Bool = false
    
    var body: some View {
        
        NavigationStack {
            NavigationLink(destination: CompleteRegistration().navigationBarBackButtonHidden(), isActive: $shouldNavigate) {
                EmptyView()
            }
            .hidden()
            
            VStack {
                Text("Create Password")
                    .padding(.bottom, 50)
                    .font(.title)
                    .bold()
                    .padding(.top, 50)
                
                VStack {
                    SecureField("Password", text: $viewModel.password)
                        .autocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                
                Button(action: {
                    if viewModel.password.count < 8 {
                        showAlert = true
                    } else {
                        shouldNavigate = true
                    }
                }) {
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
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Password Error"), message: Text("Password must be at least 8 characters long."), dismissButton: .default(Text("OK")))
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Password Error"), message: Text("Password must be at least 8 characters long."), dismissButton: .default(Text("OK")))
        }
    }
}
