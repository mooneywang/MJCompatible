//
//  QRCodeScanViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/16.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanViewController: UIViewController {}

//    var torchButton: UIButton?
//
//    let detectorFrame = CGRect(x: (UIScreen.main.bounds.width - 160) * 0.5,
//                               y: (UIScreen.main.bounds.height - 160) * 0.5,
//                               width: 160, height: 160)
////    let captureDevice = AVCaptureDevice.default(for: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)))
//    let metaDataOutput = AVCaptureMetadataOutput()
//    let captureSession = AVCaptureSession()
//    private let queue: DispatchQueue = DispatchQueue(label: "moody.capture-queue")
//    let lineImageView = UIImageView(image: UIImage(named: "CodeScan.bundle/qrcode_scan_light_green"))
//    var isAnimationing = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // 设置捕捉会话
//        configSession()
//
//        // 视频捕捉图层
//        let capturelayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        capturelayer.frame = self.view.bounds
//        self.view.layer.addSublayer(capturelayer)
//
//        // 二维码检测区域图层
//        let detectImageView = UIImageView(image: UIImage(named: "CodeScan.bundle/qrcode_scan_full_net"))
//        detectImageView.frame = detectorFrame
//        self.view.addSubview(detectImageView)
//
//        let detectRectLayer = CAShapeLayer()
//        detectRectLayer.frame = detectorFrame
//        detectRectLayer.borderColor = UIColor.green.cgColor
//        detectRectLayer.borderWidth = 1
//        self.view.layer.addSublayer(detectRectLayer)
//
//        // 设置界面操作按钮
//        setButtons()
//        self.view.addSubview(lineImageView)
//
//        // 开始捕捉
//        queue.async {
//            self.captureSession.startRunning()
//
//            // 转换捕捉区域坐标(必须在startRunning()之后)
//            let interestRect = capturelayer.metadataOutputRectConverted(fromLayerRect: self.detectorFrame)
//            self.metaDataOutput.rectOfInterest = interestRect
//        }
//
//        self.isAnimationing = true
//        self.startScanAnimation()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
////    private func configSession() {
////        captureSession.sessionPreset = AVCaptureSession.Preset(rawValue: convertFromAVCaptureSessionPreset(AVCaptureSession.Preset.high))
////        let input = try! AVCaptureDeviceInput(device: captureDevice)
////        captureSession.addInput(input)
////        captureSession.addOutput(metaDataOutput)
////        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
////
////        // 设置捕捉信息类型为二维码(必须在addOutput之后)
////        metaDataOutput.metadataObjectTypes = [convertFromAVMetadataObjectObjectType(AVMetadataObject.ObjectType.qr)]
////    }
//
//    private func setButtons() {
//        let buttonW: CGFloat = 30
//        let buttonH = buttonW
//        let backButtonRect = CGRect(x: 20, y: 20, width: buttonW, height: buttonH)
//        let torchButtonRect = CGRect(x: (UIScreen.main.bounds.width - 65) * 0.5,
//                                     y: UIScreen.main.bounds.height - 20 - 87,
//                                     width: 65, height: 87)
//
//        // 返回按钮
//        let backButton = UIButton(frame: backButtonRect)
//        backButton.setBackgroundImage(UIImage(named: "CodeScan.bundle/qrcode_scan_titlebar_back_nor"), for: .normal)
//        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
//        self.view.addSubview(backButton)
//
//        // 闪光灯按钮
//        torchButton = UIButton(frame: torchButtonRect)
//        torchButton?.setBackgroundImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for: .normal)
//        torchButton?.setBackgroundImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_scan_off"), for: .selected)
//        torchButton?.addTarget(self, action: #selector(torchButtonAction), for: UIControl.Event.touchUpInside)
//        if torchButton != nil {
//            self.view.addSubview(torchButton!)
//        }
//    }
//
//    @objc func backButtonAction() {
//        guard let device = captureDevice else {
//            return
//        }
//        if device.hasTorch {
//            if device.isTorchActive {
//                guard let _ = try? device.lockForConfiguration() else {
//                    return
//                }
//                device.torchMode = AVCaptureDevice.TorchMode.off
//                device.unlockForConfiguration()
//                torchButton?.isSelected = false
//            }
//        }
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    /**
//     闪光灯的打开／关闭
//     */
//    @objc func torchButtonAction() {
//        guard let device = captureDevice else {
//            return
//        }
//        if device.hasTorch {
//            if device.isTorchActive {
//                guard let _ = try? device.lockForConfiguration() else {
//                    return
//                }
//                device.torchMode = AVCaptureDevice.TorchMode.off
//                device.unlockForConfiguration()
//                torchButton?.isSelected = false
//            } else {
//                guard let _ = try? device.lockForConfiguration() else {
//                    return
//                }
//                device.torchMode = AVCaptureDevice.TorchMode.on
//                device.unlockForConfiguration()
//                torchButton?.isSelected = true
//            }
//        }
//    }
//
//    fileprivate func startScanAnimation() {
//        stepAnimation()
//    }
//
//    fileprivate func stopScanAnimation() {
//        isAnimationing = false
//    }
//
//    @objc func stepAnimation() {
//        if !isAnimationing {
//            return
//        }
//        var frame:CGRect = detectorFrame
//        frame.size.height = 3
//        lineImageView.frame = frame
//        lineImageView.alpha = 1.0
//        UIView.animate(withDuration: 2.0, animations: { () -> Void in
//
//            self.lineImageView.alpha = 0.0
//
//            frame.origin.y += self.detectorFrame.size.height
//            self.lineImageView.frame = frame
//
//        }, completion:{ (value: Bool) -> Void in
//
//            self.perform(#selector(self.stepAnimation), with: nil, afterDelay: 0.3)
//
//        })
//    }
//}
//
//extension QRCodeScanViewController: AVCaptureMetadataOutputObString(describing: jectsDelegate {
//
//    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        print("get QR: \(metadataObjects)")
//        captureSession.stopRunning()
//        stopScanAnimation()
//    }
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
//    return input.rawValue
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromAVCaptureSessionPreset(_ input: AVCaptureSession.Preset) -> String {
//    return input.rawValue
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertFromAVMetadataObjectObjectType(_ input: AVMetadataObject.ObjectType) -> String {
//    return input.rawValue
//}
