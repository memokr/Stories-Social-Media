//
//  LoginView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel = LoginViewModel()
    
    @State private var showAlert = false
        
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("NanoSnap").padding(.bottom,50).font(.largeTitle).bold()
                VStack(){
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization (.none)
                        .font (. subheadline)
                        .padding(12)
                        .background (Color (.systemGray6))
                        .cornerRadius(10)
                        .padding (.horizontal, 24)
                        .disableAutocorrection(true)
                
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        . font (.subheadline)
                        .padding (12)
                        .background (Color (.systemGray6) )
                        .cornerRadius (10)
                        .padding (.horizontal, 24)
                }
                
                Button {
                    print ("Show forgot password")
                } label:{
                    Text ("Forgot Password?")
                        .font(.footnote)
                        .fontWeight (.semibold)
                        .padding (.top)
                        .padding (.leading, 220)
                        .foregroundColor(colorScheme == .light ? .gray : .white)
                }
                
                Button {
                    Task {
                        await viewModel.signIn()
                        if viewModel.loginError != nil {
                            showAlert = true
                        }
                    }
                } label: {
                    Text ("Login" )
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame (width: 360, height: 44)
                        .background(Color(colorScheme == .light ? .black : .white))
                        .cornerRadius (8)
                        .padding()
                        .textContentType(.oneTimeCode)
                }
                
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                }label: {
                    VStack {
                        HStack {
                            Text ("Don't have an account?")
                            Text ("Sign Up")
                        }
                    }.padding (.vertical, 16)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                }
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login Failed"),
                    message: Text("The password is invalid or the user not have a password"),
                    dismissButton: .default(Text("OK")) {
                        viewModel.loginError = nil // Clear the error after the user dismisses the alert
                    }
                )
            }
        }
    }
}

#Preview {
    LoginView()
}
