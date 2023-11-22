//
//  DiscoverModal.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 22/11/23.
//

import SwiftUI

struct DiscoverModal: View {
    @Environment (\.dismiss) var dismiss
    
    @Environment(\.colorScheme) var colorScheme
    
    var nameImage: String
    
    var body: some View {
        NavigationView{
            ZStack {
                Image(nameImage)
                    .resizable()
                    .scaledToFill()
                    .accessibilityLabel("Discover")
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .padding(.trailing,10)
                            
                            
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DiscoverModal(nameImage: "asset_1")
}
