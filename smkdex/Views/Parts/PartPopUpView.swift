//
//  PartPopUpView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 23/07/21.
//

import SwiftUI

import SwiftUI
import SceneKit

struct PartPopUpView : View {
    @State var part: String
    @State var nameds: String
    
    func generateScene(named: String) -> SCNScene{
        let scene = SCNScene(named: "\(named).usdz")
        
        let sceneNode = SCNNode()
        
        //        sceneNode.transform = SCNMatrix4(m11: 0.1, m12: 0, m13: 0, m14: 0, m21: 0, m22: 0.1, m23: 0, m24: 0, m31: 0, m32: 0, m33: 0.1, m34: 0, m41: 0, m42: 0, m43: 0, m44: 1)
        
        
        //        sceneNode.scale = SCNVector3(x: 5, y: 5, z: 5)
        
        
//        if named == "Aki"
//        {
//            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            scene!.rootNode.position = SCNVector3(x: -5, y: 30, z: 0)
//
//        }
//        else if named == "Klakson"
//        {
//            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            scene!.rootNode.position = SCNVector3(x: 3, y: 30, z: 0)
//        }
//        else if named == "KunciKontak"
//        {
//            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            scene!.rootNode.position = SCNVector3(x: 3, y: 2, z: 0)
//        }
//        else if named == "Fuse"
//        {
//            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            scene!.rootNode.position = SCNVector3(x: 0, y: 5.5, z: 0)
//        }
        
        
        
        switch named {
        case "Aki":
            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
           // scene!.rootNode.position = SCNVector3(x: -5, y: 30, z: 0)
            scene!.rootNode.position = SCNVector3(x: -5, y: 30, z: 0)
            scene?.rootNode.lookAt(SCNVector3(0,5,0))
            
        case "Klakson":
            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            scene!.rootNode.position = SCNVector3(x: 3, y: 30, z: 0)
        case "KunciKontak":
            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            scene!.rootNode.position = SCNVector3(x: 3, y: 2, z: 0)
        case "Fuse":
            scene!.rootNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            scene!.rootNode.position = SCNVector3(x: 0, y: 5.5, z: 0)
        case "TombolKlakson":
        scene!.rootNode.scale = SCNVector3(x: 0.4, y: 0.4, z: 0.4)
            scene!.rootNode.position = SCNVector3(x: 4, y: 8.5, z: 0)
        
        default:
            break
        }
        scene!.rootNode.addChildNode(sceneNode)
        print(sceneNode.scale)
        return scene!
    }
    //    func scenes() -> AnyView {
    //        switch scenePart {
    //        case .klakson: .klakson
    //        }
    //    }
    
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 15, content: {
            SceneView(scene: generateScene(named: "\(nameds)"), options: [.autoenablesDefaultLighting,.allowsCameraControl])
                
                
                
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        })
        
    }
    
}

struct PartPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PartPopUpView(part: "test", nameds: "")
        
    }
}

extension Float {
    /// Convert degrees to radians
    func asRadians() -> Float {
        return self * Float.pi / 180
    }
}

extension SCNNode {
    /// Look at a SCNVector3 point
    func lookAt(_ point: SCNVector3) {
        // Find change in positions
        let changeX = self.position.x - point.x // Change in X position
        let changeY = self.position.y - point.y // Change in Y position
        let changeZ = self.position.z - point.z // Change in Z position

        // Calculate the X and Y angles
        let angleX = atan2(changeZ, changeY) * (changeZ > 0 ? -1 : 1)
        let angleY = atan2(changeZ, changeX)

        // Calculate the X and Y rotations
        let xRot = Float(-90).asRadians() - angleX // X rotation
        let yRot = Float(90).asRadians() - angleY // Y rotation
        self.eulerAngles = SCNVector3(CGFloat(xRot), CGFloat(yRot), 0) // Rotate
    }
}
