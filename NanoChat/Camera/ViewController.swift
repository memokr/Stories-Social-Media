//
//  ViewController.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 20/11/23.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    // Capture session
    var session: AVCaptureSession?
    // Photo output
    let output = AVCapturePhotoOutput()
    // Video preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    // Camera device
    var currentCamera: AVCaptureDevice?
    
    var coordinator: Miracle.Coordinator?
    
    var capturedImage: UIImage?

    // Shutter button
    private let shutterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.clear
        return button
    }()

    // Camera switch button
    private let switchCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Switch Camera", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
        button.isHidden = true // Hide initially
        return button
    }()
    
    private let retakeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark") // Use the system image name
        button.setImage(image, for: .normal)
        button.tintColor = .white // Set the tint color for the system image
        button.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        button.isHidden = true // Hide initially
        return button
    }()
    
    private let saveButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(systemName: "checkmark") // Use the system image name
            button.setImage(image, for: .normal)
            button.tintColor = .white
            button.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
            button.isHidden = true // Hide initially
            return button
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(switchCameraButton)
        view.addSubview(retakeButton)
        shutterButton.addTarget(self, action: #selector(getMedia), for: .touchUpInside)
        checkCameraPermissions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 100)
        switchCameraButton.frame = CGRect(x: 20, y: 20, width: 150, height: 40)
        retakeButton.frame =  CGRect(x: -50 , y: 35, width: 150, height: 60)
        saveButton.frame = CGRect(x: view.frame.size.width - 120, y: 35, width: 200, height: 60)
    }

    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // request permission
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted, .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }

    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                self.session = session
                currentCamera = device
            } catch {
                print(error)
            }
        }
    }

    @objc private func getMedia() {
        print("Get Media")
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    

    private func switchCameraInput() {
        guard let session = session else { return }

        // Remove existing inputs
        for input in session.inputs {
            session.removeInput(input)
        }

        // Toggle between front and back cameras
        if let currentInput = session.inputs.first as? AVCaptureDeviceInput {
            let currentDevice = currentInput.device

            currentCamera = currentDevice.position == .back ? frontCamera() : backCamera()
        }

        // Add new input
        if let newCamera = currentCamera,
           let newInput = try? AVCaptureDeviceInput(device: newCamera),
           session.canAddInput(newInput) {
            session.addInput(newInput)
        }
    }
    
    


    @objc private func switchCamera() {
        switchCameraInput()
    }
    

    private func frontCamera() -> AVCaptureDevice? {
        return AVCaptureDevice.devices(for: .video)
            .filter { $0.position == .front }
            .first
    }

    private func backCamera() -> AVCaptureDevice? {
        return AVCaptureDevice.devices(for: .video)
            .filter { $0.position == .back }
            .first
    }
    
    @objc private func retakePhoto() {
        // Remove the previously captured image view
        for subview in view.subviews {
            if let imageView = subview as? UIImageView {
                imageView.removeFromSuperview()
            }
        }
        retakeButton.isHidden = true 
        saveButton.isHidden = true // Hide the "Retake" button again
        session?.startRunning() // Restart the camera session
    }
    
    @objc private func savePhoto() {
           // Handle save action
           if let capturedImage = self.capturedImage {
               // Perform the action to save the image (e.g., store it in a variable or database)
               print("Image saved!")
           }
       }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
            return
        }
        capturedImage = image // Save the captured image to the property
        coordinator?.capturedImage = image
        session?.stopRunning()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
        view.addSubview(retakeButton)
        view.addSubview(saveButton)

        retakeButton.isHidden = false
        saveButton.isHidden = false
    }
}
