//
//  CameraViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet private weak var cameraView: UIView!

    private let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private let captureSessionOutput = AVCapturePhotoOutput()
    let captureOutput = AVCapturePhotoOutput()
    private var didTakePhoto = false
    var cameraViewDelegate: CameraViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

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
            let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer )
        captureSession.startRunning()

        if captureSession.canAddOutput(captureOutput) {
            captureSession.addOutput(captureOutput)
        }

        captureSession.commitConfiguration()
    }

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

        guard error == nil,
              let photoSampleBuffer = photoSampleBuffer else {
                let alert = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
                    self?.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
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
