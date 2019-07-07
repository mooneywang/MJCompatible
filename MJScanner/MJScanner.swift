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

    static let UPCECode = AVMetadataObject.ObjectType.upce
    static let Code39Code = AVMetadataObject.ObjectType.code39
    static let Code39Mod43Code = AVMetadataObject.ObjectType.code39Mod43
    static let EAN13Code = AVMetadataObject.ObjectType.ean13
    static let EAN8Code = AVMetadataObject.ObjectType.ean8
    static let Code93Code = AVMetadataObject.ObjectType.code93
    static let Code128Code = AVMetadataObject.ObjectType.code128
    static let PDF417Code = AVMetadataObject.ObjectType.pdf417
    static let QRCode = AVMetadataObject.ObjectType.qr
    static let AztecCode = AVMetadataObject.ObjectType.aztec
    static let Interleaved2of5Code = AVMetadataObject.ObjectType.interleaved2of5
    static let ITF14Code = AVMetadataObject.ObjectType.itf14
    static let DataMatrixCode = AVMetadataObject.ObjectType.dataMatrix
}

class MJScanner: NSObject {

    private let session = AVCaptureSession()
    private let device = AVCaptureDevice.default(for: AVMediaType.video)
    private var input: AVCaptureDeviceInput?
    private let output = AVCaptureMetadataOutput()

    init(vedioPreView: UIView, metaDataObjectTypes: [String]) {
        super.init()
        do {
            input = try AVCaptureDeviceInput(device: device!)
        } catch {
            print("AVCaptureDeviceInput初始化error: \(error)")
        }
        session.sessionPreset = AVCaptureSession.Preset.high
        if session.canAddInput(input!) {
            session.addInput(input!)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
//        output.metadataObjectTypes = metaDataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        _ = AVCaptureVideoPreviewLayer(session: session)

    }
}

extension MJScanner: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print(captureOutput)
    }
}
