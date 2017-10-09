//
//  CameraViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, Alertable {

    // MARK: - Private IBOutlets

    @IBOutlet private weak var cameraView: UIView!

    // MARK: - Variables

    weak var cameraViewDelegate: CameraViewDelegate?

    // MARK: - Private Constants

    private let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private let captureSessionOutput = AVCapturePhotoOutput()
    private let captureOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

     // MARK: - Private Instance Methods

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        captureDevice = device
        startCaptureSession()
    }

    private func startCaptureSession() {
        guard let captureDevice = captureDevice else { return }

        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch let error as NSError {
            showAlert(title: "Error", message: error.description)
        }

        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer)
        captureSession.startRunning()

        if captureSession.canAddOutput(captureOutput) {
            captureSession.addOutput(captureOutput)
        }

        captureSession.commitConfiguration()
    }

    // MARK: - IBOutlet Methods

    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        captureOutput.capturePhoto(with: settings, delegate: self)
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - AVCapturePhotoCaptureDelegate

    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                       didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                       previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                       resolvedSettings: AVCaptureResolvedPhotoSettings,
                       bracketSettings: AVCaptureBracketedStillImageSettings?,
                       error: Error?) {

        guard error == nil, let photoSampleBuffer = photoSampleBuffer else {
            showAlert(title: "Error", message: String(describing: error))
            return
        }

        guard let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }

        let capturedImage = UIImage(data: data)
        if let image = capturedImage {
            cameraViewDelegate?.getImage(image: image)
            dismiss(animated: true, completion: nil)
        }
    }

    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            guard let image = UIImage(data: imageData) else { return }
            cameraViewDelegate?.getImage(image: image)
            dismiss(animated: true, completion: nil)
        }
    }
}
