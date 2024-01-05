//
//  CameraLineUpViewController.swift
//  SHArchive
//
//  Created by Tario You on 2023/5/28.
//

import UIKit
import AVFoundation

class CameraLineUpViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    @IBOutlet weak var descriptionLabel: UIButton!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var whiteCircleButton: UIButton!
    
    var descriptionText: String?
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.setTitle("请把手机竖着，\n摄像头瞄准前面的地\n并短按屏幕上白色的圆形按钮", for: .normal)
        // descriptionLabel.isEnabled = false
        whiteCircleButton.setTitle("", for: .normal)
        setupCaptureSession()
        
//        let overlayImageView = UIImageView(image: UIImage(named: "wireframe.png")) 
//        overlayImageView.frame = view.bounds
//        overlayImageView.contentMode = .scaleAspectFill
//        view.addSubview(overlayImageView)
//        view.sendSubviewToBack(overlayImageView)
    }
    
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer.frame = cameraView.bounds
            cameraView.layer.addSublayer(videoPreviewLayer)
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.captureSession.startRunning()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func whiteCircleButtonPressed(_ sender: UIButton) {
        descriptionLabel.setTitle("正在加载...", for: .normal)
        performSegue(withIdentifier: "toLoad3DModel", sender: self)
    }
}
