//
//  LoginViewModel.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 16/11/23.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var loginError: Error?
    
    
    func signIn() async {
        do {
            if let error = try await AuthService.shared.login(withEmail: email, password: password) {
        
                print("Login failed with error: \(error.localizedDescription)")
                loginError = error
            } else {
                print("Login successful")
            }
        } catch {
    
            print("Unexpected error during login: \(error.localizedDescription)")
            loginError = error
        }
    }
    
}
