//
//  CaptureSession.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import AVFoundation

protocol CaptureSessionDelegate: class {
    func captureSessionDidCapture(_ image: UIImage)
}

class CaptureSession: NSObject {

    private let session: AVCaptureSession
    private let photoOutput = AVCapturePhotoOutput()
    private let queue: DispatchQueue = DispatchQueue(label: "moody.capture-queue")
    fileprivate weak var delegate: CaptureSessionDelegate!

    var isAuthorized: Bool {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video))) == .authorized
    }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return AVCaptureVideoPreviewLayer(session: session)
    }

    init(_ delegate: CaptureSessionDelegate) {
        session = AVCaptureSession()
        super.init()
        if isAuthorized {
            setup()
        } else {
            requestAuthorization()
        }
        self.delegate = delegate
    }

    private func setup() {
        session.sessionPreset = AVCaptureSession.Preset(rawValue: convertFromAVCaptureSessionPreset(AVCaptureSession.Preset.high))
        let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)), position: AVCaptureDevice.Position.back)
        if let device = discovery.devices.first {
            let input = try! AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        }
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
        }
    }

    private func requestAuthorization() {
//        AVCaptureDevice.requestAccess(for: convertFromAVMediaType(AVMediaType.video)) { authorized in
//            guard authorized else {
//                return
//            }
//            self.setup()
//        }
    }

    func start() {
        queue.async {
            self.session.startRunning()
        }
    }

    func stop() {
        queue.async {
            self.session.stopRunning()
        }
    }

    func takePhoto() {
        queue.async {
            self.photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
    }
}

extension CaptureSession: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                 didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                 previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        var image: UIImage?
        if let buf = photoSampleBuffer,
            let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buf, previewPhotoSampleBuffer: previewPhotoSampleBuffer) {
            image = UIImage(data: imageData)
        }
        if let image = image {
            self.delegate.captureSessionDidCapture(image)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVCaptureSessionPreset(_ input: AVCaptureSession.Preset) -> String {
	return input.rawValue
}
