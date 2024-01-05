//
//  DemoViewController21.swift
//  test4
//
//  Created by Tario You on 2023/7/22.
//

import ARKit
import SceneKit
import UIKit
import AVKit
import AVFoundation

class DemoViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .right{
            performSegue(withIdentifier: "right", sender: self)
        }
        else if gesture.direction == .left{
            performSegue(withIdentifier: "left", sender: self)
        }
    }
}
