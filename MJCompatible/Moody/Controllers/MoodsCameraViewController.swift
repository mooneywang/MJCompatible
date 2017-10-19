//
//  MoodsCameraViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

protocol MoodsCameraViewControllerDelegate: class {
    func didCapture(_ image: UIImage?)
}

class MoodsCameraViewController: UIViewController {

    @IBOutlet weak var cameraView: CameraView!

    private var captureSession: CaptureSession!
    weak var delegate: MoodsCameraViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = CaptureSession(self)
        cameraView.setup(for: captureSession.videoPreviewLayer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.start()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.stop()
    }
    
    @IBAction func snap(_ sender: UITapGestureRecognizer) {
        captureSession.takePhoto()
    }
}

extension MoodsCameraViewController: CaptureSessionDelegate {

    func captureSessionDidCapture(_ image: UIImage?) {
        delegate.didCapture(image)
    }
}
