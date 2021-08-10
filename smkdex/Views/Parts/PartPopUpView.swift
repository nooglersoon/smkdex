//
//  PartPopUpView.swift
//  smkdex
//
//  Created by Muhammad Gilang Nursyahroni on 23/07/21.
//

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
            scene!.rootNode.scale = SCNVector3(x: 0.3, y: 0.3, z: 0.3)
            scene!.rootNode.position = SCNVector3(x: -8, y: 45, z: 0)

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




