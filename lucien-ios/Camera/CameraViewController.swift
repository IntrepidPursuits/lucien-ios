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

    @IBOutlet weak var cameraView: UIView!

    private var captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var captureSessionOutput = AVCapturePhotoOutput()
    private var didTakePhoto = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
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
        } catch _ {}

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer!)
        captureSession.startRunning()

        let captureOutput = AVCaptureVideoDataOutput()
        captureOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String) : NSNumber(value: kCVPixelFormatType_32BGRA)]
        captureOutput.alwaysDiscardsLateVideoFrames = true

        if captureSession.canAddOutput(captureOutput) {
            captureSession.addOutput(captureOutput)
        }
        captureSession.commitConfiguration()

        let queue = DispatchQueue(label: "com.lucien-ios.captureQueue")
        captureOutput.setSampleBufferDelegate(self, queue: queue)
    }

    @IBAction func flashButtonTapped(_ sender: UIButton) {

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
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {}
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
