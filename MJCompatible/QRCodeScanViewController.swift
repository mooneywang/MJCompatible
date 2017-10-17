//
//  QRCodeScanViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/16.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScanViewController: UIViewController {

    let detectorFrame = CGRect(x: (UIScreen.main.bounds.width - 160) * 0.5,
                               y: (UIScreen.main.bounds.height - 160) * 0.5,
                               width: 160, height: 160)
    let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    let metaDataOutput = AVCaptureMetadataOutput()
    let captureSession = AVCaptureSession()
    let lineImageView = UIImageView(image: UIImage(named: "CodeScan.bundle/qrcode_scan_light_green"))
    var isAnimationing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置捕捉会话
        configSession()

        // 视频捕捉图层
        let capturelayer = AVCaptureVideoPreviewLayer(session: captureSession)
        capturelayer?.frame = self.view.bounds
        self.view.layer.addSublayer(capturelayer!)

        // 二维码检测区域图层
        let detectImageView = UIImageView(image: UIImage(named: "CodeScan.bundle/qrcode_scan_full_net"))
        detectImageView.frame = detectorFrame
        self.view.addSubview(detectImageView)

        let detectRectLayer = CAShapeLayer()
        detectRectLayer.frame = detectorFrame
        detectRectLayer.borderColor = UIColor.green.cgColor
        detectRectLayer.borderWidth = 1
        self.view.layer.addSublayer(detectRectLayer)

        // 设置界面操作按钮
        setButtons()
        self.view.addSubview(lineImageView)

        // 开始捕捉
        captureSession.startRunning()
        isAnimationing = true
        startScanAnimation()

        // 转换捕捉区域坐标
        let interestRect = capturelayer?.metadataOutputRectOfInterest(for: detectorFrame)
        metaDataOutput.rectOfInterest = interestRect!
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    private func configSession() {
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        let input = try! AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(input)
        captureSession.addOutput(metaDataOutput)
        metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }

    private func setButtons() {
        let buttonW: CGFloat = 30
        let buttonH = buttonW
        let backButtonRect = CGRect(x: 20, y: 20, width: buttonW, height: buttonH)
        let torchButtonRect = CGRect(x: (UIScreen.main.bounds.width - 65) * 0.5,
                                     y: UIScreen.main.bounds.height - 20 - 87,
                                     width: 65, height: 87)

        // 返回按钮
        let backButton = UIButton(frame: backButtonRect)
        backButton.setBackgroundImage(UIImage(named: "CodeScan.bundle/qrcode_scan_titlebar_back_nor"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)

        // 闪光灯按钮
        let torchButton = UIButton(frame: torchButtonRect)
        torchButton.setBackgroundImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for: .normal)
        torchButton.addTarget(self, action: #selector(torchButtonAction), for: UIControlEvents.touchUpInside)
        self.view.addSubview(torchButton)
    }

    func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    /**
     闪光灯的打开／关闭
     */
    func torchButtonAction() {
        guard let device = captureDevice else {
            return
        }
        if device.hasTorch {
            if device.isTorchActive {
                guard let _ = try? device.lockForConfiguration() else {
                    return
                }
                device.torchMode = AVCaptureTorchMode.off
                device.unlockForConfiguration()
            } else {
                guard let _ = try? device.lockForConfiguration() else {
                    return
                }
                device.torchMode = AVCaptureTorchMode.on
                device.unlockForConfiguration()
            }
        }
    }

    fileprivate func startScanAnimation() {
        stepAnimation()
    }

    fileprivate func stopScanAnimation() {
        isAnimationing = false
    }

    func stepAnimation() {
        if !isAnimationing {
            return
        }
        var frame:CGRect = detectorFrame
        frame.size.height = 3
        lineImageView.frame = frame
        lineImageView.alpha = 1.0
        UIView.animate(withDuration: 2.0, animations: { () -> Void in

            self.lineImageView.alpha = 0.0

            frame.origin.y += self.detectorFrame.size.height
            self.lineImageView.frame = frame

        }, completion:{ (value: Bool) -> Void in

            self.perform(#selector(self.stepAnimation), with: nil, afterDelay: 0.3)

        })
    }
}

extension QRCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print("get QR: \(metadataObjects)")
        captureSession.stopRunning()
        stopScanAnimation()
    }
}