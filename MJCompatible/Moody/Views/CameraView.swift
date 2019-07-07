//
//  CameraView.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView {

    private var previewLayer: AVCaptureVideoPreviewLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }

    private func setup() {
        backgroundColor = .black
    }

    func setup(for previewLayer: AVCaptureVideoPreviewLayer) {
        previewLayer.videoGravity = AVLayerVideoGravity(rawValue: convertFromAVLayerVideoGravity(AVLayerVideoGravity.resizeAspectFill))
        layer.insertSublayer(previewLayer, at: 0)
        self.previewLayer = previewLayer
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVLayerVideoGravity(_ input: AVLayerVideoGravity) -> String {
	return input.rawValue
}
