//
//  MoodsCameraViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/19.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit

class MoodsCameraViewController: UIViewController {

    @IBOutlet weak var cameraView: CameraView!

    let captureSession: CaptureSession = CaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.setup(for: captureSession.videoPreviewLayer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
