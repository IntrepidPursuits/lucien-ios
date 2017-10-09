//
//  CameraViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet private weak var cameraView: UIView!

    private let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private let captureSessionOutput = AVCapturePhotoOutput()
    private var didTakePhoto = false

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

        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_32BGRA)]
        captureOutput.alwaysDiscardsLateVideoFrames = true

        if captureSession.canAddOutput(captureOutput) {
            captureSession.addOutput(captureOutput)
        }
        captureSession.commitConfiguration()

        let queue = DispatchQueue(label: LucienConstants.captureQueueName)
        captureOutput.setSampleBufferDelegate(self, queue: queue)
    }

    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        didTakePhoto = true
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if didTakePhoto {
            didTakePhoto = false
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                // TODO: Send image back to AddComicViewController.
            }
        }
    }

    private func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let ciContext = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            if let image = ciContext.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        return nil
    }
}
