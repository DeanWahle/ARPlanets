//
//  ViewController.swift
//  ARPlanets
//
//  Created by Dean Wahle on 1/17/22.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //creating sun
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun diffuse")
        sun.position = SCNVector3(x: 0, y: 0, z: -1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        earthParent.position = SCNVector3(x: 0, y: 0, z: -1)
        venusParent.position = SCNVector3(x: 0, y: 0, z: -1)
        moonParent.position = SCNVector3(x: 1.2, y: 0, z:0)
       
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: "Earth day", specular: "Earth specular", emission: "Earth emission", normal: "Earth normal", position: SCNVector3(1.2,0,0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: "Venus diffuse", specular: "", emission: "Venus emission", normal: "", position: SCNVector3(0.7,0,0))
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: "moon Diffuse", specular: "", emission: "", normal: "", position: SCNVector3(0,0,-0.3))
       
        //position earth relative to the sun
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        //position earth relative to the sun
        venusParent.addChildNode(venus)
        
        earth.addChildNode(moon)
        moonParent.addChildNode(moon)
        
        
        let earthRotation = SCNAction.rotateBy(x: 0, y: CGFloat(degreesToRadians(num: 360)), z: 0, duration: 8)
        let venusRotation = SCNAction.rotateBy(x: 0, y: CGFloat(degreesToRadians(num: 360)), z: 0, duration: 8)
        let foreverEarthRotation = SCNAction.repeatForever(earthRotation)
        let foreverVenusRotation = SCNAction.repeatForever(venusRotation)
        earth.runAction(foreverEarthRotation)
        venus.runAction(foreverVenusRotation)
        
        //sun animations
        let sunAction = rotation(time: 8)
        sun.runAction(sunAction)
        
        //earth animations
        let earthParentRotation = rotation(time: 14)
        earthParent.runAction(earthParentRotation)
        let earthAction = rotation(time: 8)
        earth.runAction(earthAction)
        
        //venus animations
        let venusParentRotation = rotation(time: 10)
        venusParent.runAction(venusParentRotation)
        let venusAction = rotation(time: 8)
        venus.runAction(venusAction)
        
        //moon animation
        let moonRotation = rotation(time: 5)
        moonParent.runAction(moonRotation)
        
        
        
//        //rotate around y axis
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(self.degreesToRadians(num: 360)), z: 0, duration: 8)
//        //animate action forever
//        let forever = SCNAction.repeatForever(action)
//        //run action
//        earth.runAction(forever)
    }
    
    func planet(geometry: SCNGeometry, diffuse: String, specular: String, emission: String, normal: String, position: SCNVector3) -> SCNNode{
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = UIImage(named: diffuse)
        planet.geometry?.firstMaterial?.specular.contents = UIImage(named: specular)
        planet.geometry?.firstMaterial?.emission.contents = UIImage(named: emission)
        planet.geometry?.firstMaterial?.normal.contents = UIImage(named: normal)
        planet.position = position
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction{
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(degreesToRadians(num: 360)), z: 0, duration: time)
        let foreverAction = SCNAction.repeatForever(Rotation)
        return foreverAction
    }
    
    //convert degrees to radians
    func degreesToRadians(num: Int) -> Double{
        return Double(num) * .pi/180
    }

}

