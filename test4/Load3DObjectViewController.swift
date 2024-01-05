//
//  Load3DModelViewController.swift
//  SHArchive
//
//  Created by Tario You on 2023/5/28.
//

import SwiftUI
import UIKit
import RealityKit
import ARKit
import AVFoundation

var x = 1

class Load3DModelViewController: UIViewController, ARSCNViewDelegate {
    
//    @IBOutlet weak var arView: ARView!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var descriptionLabel: UIButton!
    
    var firstModelNode: SCNNode?
    var secondModelNode: SCNNode?
    var thirdModelNode: SCNNode?
    
    // var modelEntity: Entity?
    
    // touch trigger
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.setTitle("在老西门上海文庙旁，坐落着一座1923年建造的迷人府邸。文庙路153号由黄金荣大亨的弟子王伟雄创造。曾用于燃料生意，后转为房地产公司办公楼，偶有居民。江南传统三合院平面，东侧车库和辅助用房，总面积380平方米。水泥砂浆外观，南侧五山屏风墙与中国纹样装饰。独特之处在于二层前厢房南侧加入西洋式混凝阳台和铸铁栏杆。中西合璧，府邸融合江南传统与西方魅力。", for: .normal)

        sceneView.delegate = self

//        sceneView.showsStatistics = true
        
        descriptionLabel.isHidden = true
        descriptionLabel.isEnabled = false
        
        let padding: CGFloat = 10.0
        descriptionLabel.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)

        let scene = SCNScene()
        
        if let thirdModelScene = SCNScene(named: "Models.scnassets/model4/star.scn"), let firstModelScene = SCNScene(named: "Models.scnassets/model0/laoximen1.scn") {
            thirdModelNode = thirdModelScene.rootNode.childNodes.first
            if let thirdModelNode = thirdModelNode {
                let thirdAnchor = ARAnchor(transform: matrix_identity_float4x4)
                sceneView.session.add(anchor: thirdAnchor)
                // thirdModelNode.position = SCNVector3(0, 0, 0)
                scene.rootNode.addChildNode(thirdModelNode)

                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                                sceneView.addGestureRecognizer(tapGesture)
                
                let firstModelNode = firstModelScene.rootNode.childNodes.first
                if let firstModelNode = firstModelNode {
                    if let thirdAnchorTransform = sceneView.session.currentFrame?.anchors.first?.transform {
                        firstModelNode.transform = SCNMatrix4(thirdAnchorTransform)
                    }
                    scene.rootNode.addChildNode(firstModelNode)

                    //firstModelNode.isUserInteractionEnabled = true
                    /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                    sceneView.addGestureRecognizer(tapGesture)*/
                } else {
                    print("Failed to load first model .scn file.")
                }
            }
        } else {
            print("Failed to load third model .scn file.")
        }
        
        /*if let firstModelScene = SCNScene(named: "Models.scnassets/model0/laoximen1.scn") {
            firstModelNode = firstModelScene.rootNode.childNodes.first
            if let firstModelNode = firstModelNode {
                let firstAnchor = ARAnchor(transform: matrix_identity_float4x4)
                sceneView.session.add(anchor: firstAnchor)
                firstModelNode.position = SCNVector3(-3,-1,0) // Adjust the position of the first model
                scene.rootNode.addChildNode(firstModelNode)
            }
        } else {
            print("Failed to load first model .scn file.")
        }*/

        sceneView.scene = scene
    }
    
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let sceneView = gestureRecognizer.view as? ARSCNView else { return }
        let touchLocation = gestureRecognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(touchLocation, options: [:])

        if let thirdModelNode = thirdModelNode,
           let hitNode = hitTestResults.first?.node,
           hitNode == thirdModelNode {

            descriptionLabel.isHidden = !descriptionLabel.isHidden
            descriptionLabel.setTitle("在老西门上海文庙旁，坐落着一座1923年建造的迷人府邸。文庙路153号由黄金荣大亨的弟子王伟雄创造。曾用于燃料生意，后转为房地产公司办公楼，偶有居民。江南传统三合院平面，东侧车库和辅助用房，总面积380平方米。水泥砂浆外观，南侧五山屏风墙与中国纹样装饰。独特之处在于二层前厢房南侧加入西洋式混凝阳台和铸铁栏杆。中西合璧，府邸融合江南传统与西方魅力。", for: .normal)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
}

