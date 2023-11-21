//
//  LiveCamera.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 20/11/23.
//

import SwiftUI

struct LiveCamera: View {
    
    @StateObject private var model = FrameHandler()
    let heightRatio: CGFloat = 0.5

    var body: some View {
        GeometryReader { geo in
            
            VStack{
                FrameView(image: model.frame)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LiveCamera()
}
