//
//  CompleteRegistration.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import SwiftUI

struct CompleteRegistration: View {
    
    @Environment (\.dismiss) var dismiss
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        NavigationStack{
            VStack {
                
                Text("Welcome to Nano Snap,  \n  \(viewModel.username)").padding(.bottom,50).font(.title).bold().padding(.top,50).multilineTextAlignment(.center)
                
            }
            
            Button {
                Task {try await viewModel.createUser()}
            } label: {
                Text ("Complete Sign up" )
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor (.white)
                    .frame (width: 360, height: 44)
                    .background (Color (colorScheme == .light ? .black : .white))
                    .cornerRadius (8)
                    .padding (.vertical)
                    .padding()
            }
            
            
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

