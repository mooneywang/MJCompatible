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
        return AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == .authorized
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
        session.sessionPreset = AVCaptureSessionPresetHigh
        let discovery = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.back)
        if let device = discovery?.devices.first {
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
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { authorized in
            guard authorized else {
                return
            }
            self.setup()
        }
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

    func capture(_ captureOutput: AVCapturePhotoOutput,
                 didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
                 previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings,
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
