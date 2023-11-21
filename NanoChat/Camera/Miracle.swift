//
//  Miracle.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 20/11/23.
//

import SwiftUI
import AVFoundation

struct Miracle: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        var parent: Miracle
        var capturedImage: UIImage?

        init(parent: Miracle) {
            self.parent = parent
        }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
                return
            }
            parent.image = image
        }
    }
    
    @Binding var image: UIImage?
    @State private var isRetakeButtonVisible = false

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        let cameraController = ViewController()
        cameraController.coordinator = context.coordinator
        viewController.addChild(cameraController)
        viewController.view.addSubview(cameraController.view)
        cameraController.didMove(toParent: viewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Check if the image is captured
        if let _ = image {
            // Show retake button
            isRetakeButtonVisible = true
            print("UpdateUI called with image")
            
            // Add the retake button to the view
            let retakeButton = Button("Retake") {
                // Handle retake action
                self.image = nil
                self.isRetakeButtonVisible = false
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .offset(y: -50) // Adjust the offset as needed
            
            let saveButton = Button("Save") {
                 }
                 .foregroundColor(.white)
                 .padding()
                 .background(Color.green)
                 .cornerRadius(8)
                 .offset(y: -50) // Adjust the offset as needed
        }
    }
}
