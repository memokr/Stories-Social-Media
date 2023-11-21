//
//  MainTabView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 14/11/23.
//
import SwiftUI

class ImageCaptureState: ObservableObject {
    @Published var capturedImage: UIImage?
}

struct MainTabView: View {
    let user: User
    @StateObject private var imageCaptureState = ImageCaptureState()

    var body: some View {
        TabView {
            VStack {
                if let image = imageCaptureState.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150) // Adjust the size of the displayed image
                    RetakeButton(imageCaptureState: imageCaptureState)
                } else {
                    Miracle(image: $imageCaptureState.capturedImage)
                        .edgesIgnoringSafeArea(.top)
                }
            }
            .tabItem {
                Image(systemName: "camera")
                Text("Camera")
            }

            StoriesView(current_user: user)
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Stories")
                }
        }
    }
}

struct RetakeButton: View {
    @ObservedObject var imageCaptureState: ImageCaptureState

    var body: some View {
        Button("Retake") {
            // Handle retake action
            self.imageCaptureState.capturedImage = nil
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(8)
        .padding(.top, 16) // Adjust the top padding as needed
    }
}
