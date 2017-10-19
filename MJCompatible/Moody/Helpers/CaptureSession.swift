//
//  CaptureSession.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureSession: NSObject {

    private let session: AVCaptureSession
    private let queue: DispatchQueue = DispatchQueue(label: "moody.capture-queue")

    var isAuthorized: Bool {
        return AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) == .authorized
    }
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return AVCaptureVideoPreviewLayer(session: session)
    }

    override init() {
        session = AVCaptureSession()
        super.init()
        if isAuthorized {
            setup()
        } else {
            requestAuthorization()
        }
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
        let photoOutput = AVCapturePhotoOutput()
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
}

extension CaptureSession: AVCapturePhotoCaptureDelegate {

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishRecordingLivePhotoMovieForEventualFileAt outputFileURL: URL, resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didCapturePhotoForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishCaptureForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, willBeginCaptureForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, willCapturePhotoForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingLivePhotoToMovieFileAt outputFileURL: URL, duration: CMTime, photoDisplay photoDisplayTime: CMTime, resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        print("")
    }

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingRawPhotoSampleBuffer rawSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        print("")
    }
}
