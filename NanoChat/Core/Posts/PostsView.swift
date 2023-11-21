//
//  PostsView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 21/11/23.
//

import SwiftUI

struct PostsView: View {
    
    let post: Post
    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(post.imageUrl)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
             
  
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding(.trailing,50)
                          
                                
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
    PostsView(post: Post.MOCK_POSTS[0])
}
