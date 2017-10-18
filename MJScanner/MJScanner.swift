//
//  MJScanner.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/17.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct MJScannerMetaDataType {

    static let UPCECode = AVMetadataObjectTypeUPCECode
    static let Code39Code = AVMetadataObjectTypeCode39Code
    static let Code39Mod43Code = AVMetadataObjectTypeCode39Mod43Code
    static let EAN13Code = AVMetadataObjectTypeEAN13Code
    static let EAN8Code = AVMetadataObjectTypeEAN8Code
    static let Code93Code = AVMetadataObjectTypeCode93Code
    static let Code128Code = AVMetadataObjectTypeCode128Code
    static let PDF417Code = AVMetadataObjectTypePDF417Code
    static let QRCode = AVMetadataObjectTypeQRCode
    static let AztecCode = AVMetadataObjectTypeAztecCode
    static let Interleaved2of5Code = AVMetadataObjectTypeInterleaved2of5Code
    static let ITF14Code = AVMetadataObjectTypeITF14Code
    static let DataMatrixCode = AVMetadataObjectTypeDataMatrixCode
}

class MJScanner: NSObject {

    private let session = AVCaptureSession()
    private let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    private var input: AVCaptureDeviceInput?
    private let output = AVCaptureMetadataOutput()

    init(vedioPreView: UIView, metaDataObjectTypes: [String]) {
        super.init()
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch {
            print("AVCaptureDeviceInput初始化error: \(error)")
        }
        session.sessionPreset = AVCaptureSessionPresetHigh
        if session.canAddInput(input!) {
            session.addInput(input!)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        output.metadataObjectTypes = metaDataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)

    }
}

extension MJScanner: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print(captureOutput)
    }
}
