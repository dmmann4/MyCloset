//
//  ThirdARViewController.swift
//  SecondAttempt
//
//  Created by David Mann on 7/29/19.
//  Copyright © 2019 David Mann. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ThirdARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var finalView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        finalView.delegate = self
        
        self.finalView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        finalView.automaticallyUpdatesLighting = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        finalView.scene = scene
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        finalView.addGestureRecognizer(gestureRecognizer)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        finalView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        finalView.session.pause()
    }
    
    private func addPlane2(hitTestResult: ARHitTestResult) {
        let scene = SCNScene(named: "art.scnassets/model/bootModelW_Face.scn")!
        let planeNode = scene.rootNode.childNode(withName: "modelNode", recursively: true)
        
        planeNode?.position = SCNVector3(hitTestResult.worldTransform.columns.3.x,hitTestResult.worldTransform.columns.3.y, hitTestResult.worldTransform.columns.3.z)
        planeNode?.scale = .init(0.008, 0.008, 0.008)
        
        finalView.scene.rootNode.addChildNode(planeNode!)
    }
    
    
    @objc func tapped(recognizer: UIGestureRecognizer) {
        // Get exact position where touch happened on screen of iPhone (2D coordinate)
        let touchPosition = recognizer.location(in: finalView)
        
        // Conduct a hit test based on a feature point that ARKit detected to find out what 3D point this 2D coordinate relates to
        let hitTestResult = finalView.hitTest(touchPosition, types: .featurePoint)
        
        if !hitTestResult.isEmpty {
            
            guard let hitResult = hitTestResult.first else {
                return
            }
            print(hitResult.worldTransform.columns.3)
            
            addPlane2(hitTestResult: hitResult)
        }
        recognizer.isEnabled = false
    }
    
    //
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            
            print("plane detected")
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            
            let planeNode = SCNNode()
            
            planeNode.geometry = plane
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            node.addChildNode(planeNode)
            
        } else {
            return
        }
        
    }
    
}
