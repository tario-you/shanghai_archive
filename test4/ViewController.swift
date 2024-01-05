//
//  ViewController.swift
//  test4
//
//  Created by Tario You on 2023/7/22.
//

import ARKit
import SceneKit
import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var demoButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    var button2text: String = "看教程，学建模!"
    var button3text: String = "了解我们~"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        demoButton.setTitle(button2text, for: .normal)
        aboutButton.setTitle(button3text, for: .normal)
        
        launchButton.setTitleColor(UIColor.white, for: .normal)
        demoButton.setTitleColor(UIColor.white, for: .normal)
        aboutButton.setTitleColor(UIColor.white, for: .normal)
        
        launchButton.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        demoButton.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        aboutButton.setTitleColor(UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), for: .highlighted)
        
        launchButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        demoButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        aboutButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    // var once = true
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if once {
        let hasPlayedVideo = UserDefaults.standard.bool(forKey: "hasPlayedVideo")
        if !hasPlayedVideo{
            playVideo()
            // once = false
            UserDefaults.standard.set(true, forKey: "hasPlayedVideo")
        }
    }

    let playerController = AVPlayerViewController()

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "intro_3s", ofType: "mp4") else {
            debugPrint("intro_3s.mp4 not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        playerController.showsPlaybackControls = false
        playerController.player = player
        playerController.videoGravity = .resizeAspectFill
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
        
        present(playerController, animated: true) {
            player.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + player.currentItem!.duration.seconds - 1.0) {
                let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
                fadeOutAnimation.fromValue = 1.0
                fadeOutAnimation.toValue = 0.0
                fadeOutAnimation.duration = 0.3 
                
                self.playerController.view.layer.add(fadeOutAnimation, forKey: "fadeOut")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutAnimation.duration-0.5) {
                    self.playerController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished")
        playerController.dismiss(animated: false){}
    }
}

