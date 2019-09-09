//
//  ViewController.swift
//  SecondAttempt
//
//  Created by David Mann on 6/30/19.
//  Copyright © 2019 David Mann. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class FirstARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        sceneView.delegate = self
        
 
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
        
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        

        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Shirt Pictures", bundle: Bundle.main) {

            configuration.detectionImages = imageToTrack

            configuration.maximumNumberOfTrackedImages = 2

            print("Images Successfully Added")

        }
        // Run the view's session
        sceneView.session.run(configuration)
        initalAlert(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    
    public func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

        let node = SCNNode()

        if let imageAnchor = anchor as? ARImageAnchor {

            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)

            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)

            let planeNode = SCNNode(geometry: plane)

            planeNode.eulerAngles.x = -.pi / 2

            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "blue_Shirt" {
                self.showSimpleActionSheet2(controller: self)
            }
            
            if imageAnchor.referenceImage.name == "black_jacket" {
                self.showSimpleActionSheet1(controller: self)
            }
            
        }
        return node
        
    }
    
    
    func showSimpleActionSheet1(controller: UIViewController) {
        let alert = UIAlertController(title: "Cool Black Jacket!", message: "Do you want to try this on?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler: { (_) in
           self.performSegue(withIdentifier: "moveToFinalAR", sender: self)
        
        }))
    
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showSimpleActionSheet2(controller: UIViewController) {
        let alert = UIAlertController(title: "That Blue Button-Up would look great on you!", message: "Do you want to try this on?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "showTheOtherARFinalView", sender: self)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func initalAlert(controller: UIViewController) {
        let alert = UIAlertController(title: "Find an image of the item you want to try on and scan it!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
    }
}




